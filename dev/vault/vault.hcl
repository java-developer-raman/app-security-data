listener "tcp" {
 address = "0.0.0.0:8300"
 tls_disable = 0
 tls_cert_file = "/home/raman/programs/servers/vault/certifictes/vault-tls-public.pem"
 tls_key_file = "/home/raman/programs/servers/vault/vault-tls-private.pem"
}

storage "file" {
 path = "/home/raman/programs/servers/vault/data"
}
ui = true