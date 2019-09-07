How to generate certificates for Vault SSL communication
========================================================

Certificates created via Vault's Pki service to enable SSl / TLS on Vault. 

Run this command to create certificate
--------------------------------------
vault write -format=json pki_int/issue/vault \
common_name="vault-tls" ip_sans="127.0.0.1" | tee \
>(jq -r .data.certificate > vault-tls-certificate.pem) \
>(jq -r .data.issuing_ca > vault-tls-issuing-ca.pem) \
>(jq -r .data.private_key > vault-tls-private-key.pem)


---------------------------------
Other options for advance changes
---------------------------------

To update the ttl of a role "vault" e.g. 720h to 780h. Please run this command
------------------------------------------------------------------------------
vault write pki_int/roles/vault \
          allow_any_name=true \
          max_ttl="720h" \
          generate_lease=true


To update the policy for the role
---------------------------------
1. Please update vault-tls.hcl file
2. Then run vault policy write vault-tls vault-tls.hcl




