######################### Pre Steps ###################
mkdir policies certificates config
##########################################  Create Certificates  #####################################
# Create TLS certificates
openssl req -x509 -batch -nodes -newkey rsa:2048 -keyout certificates/vault-tls-private.pem -out certificates/vault-tls-public.pem -config certificate.conf -days 999

# Create cert certificates
openssl req -x509 -batch -nodes -newkey rsa:2048 -keyout certificates/vault-cert-private.pem -out certificates/vault-cert-public.pem -subj '/CN=sharma.com/O=personal/C=DE/ST=BAYERN/L=Munich' -days 999

# Copy tls certificate so that system works with self signed certificate
sudo cp vault-tls-public.pem /etc/ssl/certs/
##########################################  Setup Vault Server  #####################################

#Start server
vault server -config=vault.hcl

#Initalize Vault, it will create tokens and unseal keys, save them in some file
vault operator init

#Unseal the Vault server, You need to fire command three times with different unseal key every time
vault operator unseal <Unseal key 1>
vault operator unseal <Unseal key 2>
vault operator unseal <Unseal key 3>
vault login <Root token>

#Enable secret engine, When it is not available
vault secrets enable -path=secret kv

##############################  Enable CERT Authentication In Vault Server #####################################

#Write policy for cert authentication, it is required to write or update secrets, or renew tokens and so on
vault policy write vault-cert-policy policies/vault-cert-policy.hcl

#Enable cert authentication
vault auth enable cert

#Upload cert authentication certificates
vault write auth/cert/certs/vault-cert display_name=vault-cert policies=vault-cert-policy certificate=@certificates/vault-cert-public.pem

#Try to login using certificates
vault login -method=cert -client-cert=certificates/vault-cert-public.pem -client-key=certificates/vault-cert-private.pem name=vault-cert

#############################Enable CERT Authentication for Spring application###############################

# Create a keystore which will be used by applications to connect to Vault
openssl pkcs12 -export -in vault-cert-public.pem -inkey vault-cert-private.pem -certfile vault-cert-public.pem -out vault-cert.pkcs12
Password: vault-cert

# Export public tls certificate into trust store of spring application
keytool -import -alias vault -file certificates/vault-tls-public.pem -storetype pkcs12 -keystore config-server-trust-store.jks

# Delete the certificate first if it already exists with same alias
keytool -delete -noprompt -alias vault -keystore config-server-trust-store.jks

########################### Enable encryption as service #########################################
1. vault secrets enable transit

2. Create Encryption key ring (Here "einwohner" is keyname, choose your own name)
   vault write -f transit/keys/einwohner
   vault write -f transit/keys/einwohner-startup

3. Encrypt the text
   vault write transit/encrypt/einwohner plaintext=$(base64 <<< "einwohner_dev_app_user")
   Result : vault:v1:KjoQHOho2/Sg46Z+TVbq9+7DK9VtwDagT0Kq6bBnR6PV6FCaHHYjbqKLDnQGHQHGn40K
   vault write transit/encrypt/einwohner plaintext=$(base64 <<< "einwohner_dev_admin_user")
   Result : vault:v1:wCt0DQunfTmiAQ39yoKcmiLbPKbPcEL2M1SBVXsJTEz9VPzxf2/y5XOTaTiJflFMWZ3Ld+Q=
   
   vault write transit/encrypt/einwohner-startup plaintext=$(base64 <<< "einwohner")
   Result : vault:v1:zTvY3JafvAe6ZUdMLu1jj12l0PUXmxL7OqQBB0XnFLLl9Qi4h/M=
base64 --decode <<< $(./vault write transit/decrypt/einwohner ciphertext="vault:v1:zTvY3JafvAe6ZUdMLu1jj12l0PUXmxL7OqQBB0XnFLLl9Qi4h/M=")
4. Decrypt the text
   base64 --decode <<< $(./vault write transit/decrypt/einwohner ciphertext="vault:v1:D+2x1DJBsuZJ3elTkeiCZmJqbGWOVKZglsCwzr+HUcwGeFjSw1B2FwVtGG2tSoSYj4Jv")
   base64 --decode <<< ZWlud29obmVyX2Rldl9hcHBfdXNlcgo=
   Result : einwohner_dev_app_user
   
   vault write transit/decrypt/einwohner ciphertext="vault:v1:Yxx/eAmRH2BGbhbVkXm6XR4R7AIgwPcQCuvOKiv6BQAwN8oewpBkGhcvNjFDtzCwO1kT6nA="
   base64 --decode <<< ZWlud29obmVyX2Rldl9hZG1pbl91c2VyCg==
   Result: einwohner_dev_admin_user
   
5. Rotate the key
   vault write -f transit/keys/einwohner/rotate

6. Rewrap or re encrypt data enrypted with old key
   vault write transit/rewrap/einwohner ciphertext="vault:v1:D+2x1DJBsuZJ3elTkeiCZmJqbGWOVKZglsCwzr+HUcwGeFjSw1B2FwVtGG2tSoSYj4Jv"
   Result: vault:v2:D+2x1DJBsuZJ3elTkeiCZmJqbGWOVKZglsCwzr+HUcwGeFjSw1B2FwVtGG2tSoSYj4Jv



