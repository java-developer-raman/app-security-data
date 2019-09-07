vault-cert-certificate.pem : Certificate to be used to login into Vault via CERT
vault-cert-private-key.pem : Private Key to be used to login into Vault via CERT
vault-cert.pkcs12 : Key store containing both private key and certificate. Will be used by Java applications to connect vault.
Password: vault-cert


Command to login into Vault
===========================
./vault login -method=cert -client-cert=vault-cert-certificate.pem -client-key=vault-cert-private-key.pem name=vault-cert


Command to create a keystore
============================
openssl pkcs12 -export -in vault-cert-certificate.pem -inkey vault-cert-private-key.pem -certfile vault-cert-certificate.pem -out vault-cert.pkcs12