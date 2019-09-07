Create Certificates for applications
====================================

Config Server
-------------
1. Create keypairs for config-server
 keytool -genkeypair -alias config-server -keyalg RSA -keysize 2048 -storetype pkcs12 -keystore config-server.jks
 Password: config-server
2. Create public certificate
 keytool -export -alias config-server -file config-server.crt -keystore config-server.jks
3. Import einwohner certificate into config-server trust store
 keytool -import -alias einwohner -file einwohner.crt -keystore config-server.jks
4. Create RSA pair for encryption and decryption
  keytool -genkeypair -alias config-server-crypto -keyalg RSA -keysize 2048 -storetype pkcs12 -keystore config-server-crypto.jks
  Password: config-server-crypto
Einwohner Server
-------------
1. Create keypairs for einwohner
 keytool -genkeypair -alias einwohner -keyalg RSA -keysize 2048 -storetype pkcs12 -keystore einwohner.jks
 Password: einwohner
2. Create public certificate
 keytool -export -alias einwohner -file einwohner.crt -keystore einwohner.jks
3. Import config-server certificate into einwohner trust store
 keytool -import -alias config-server -file config-server.crt -keystore einwohner.jks


