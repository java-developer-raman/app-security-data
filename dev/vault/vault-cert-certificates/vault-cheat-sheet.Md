How to list policies
====================
./vault policy list

Writing policy
================
./vault policy write vault-cert vault-cert.hcl

Read policy
===========
./vault policy read vault-cert

Enable encryption as service
=============================
https://learn.hashicorp.com/vault/encryption-as-a-service/eaas-transit

1. vault secrets enable transit

2. Create Encryption key ring
   vault write -f transit/keys/einwohner

3. Encrypt the text
   ./vault write transit/encrypt/einwohner plaintext=$(base64 <<< "einwohner_dev_app_user")
   Result : vault:v1:KjoQHOho2/Sg46Z+TVbq9+7DK9VtwDagT0Kq6bBnR6PV6FCaHHYjbqKLDnQGHQHGn40K
   ./vault write transit/encrypt/einwohner plaintext=$(base64 <<< "einwohner_dev_admin_user")
   Result : vault:v1:wCt0DQunfTmiAQ39yoKcmiLbPKbPcEL2M1SBVXsJTEz9VPzxf2/y5XOTaTiJflFMWZ3Ld+Q=

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
