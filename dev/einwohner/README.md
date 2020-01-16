How to login
============
vault login -method=cert -client-cert=certificates/vault-cert-public.pem -client-key=certificates/vault-cert-private.pem name=vault-cert

How to store secrets
====================
./vault-write-secret.sh einwohner-dev-1.0-SNAPSHOT-config.json

How to get secrets
==================
$HOME/programs/servers/vault/vault kv get secret/einwohner-1.0-SNAPSHOT,dev


Steps to store properties
=========================
