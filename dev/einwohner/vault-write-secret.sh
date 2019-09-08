# Write einwohner application properties in vault
./vault write secret/einwohner,dev 'spring.datasource.url=jdbc:mysql://192.168.2.108:3306/einwohner_dev?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC' 'spring.datasource.username=einwohner_dev_app_user' 'spring.datasource.password=vault:v1:KjoQHOho2/Sg46Z+TVbq9+7DK9VtwDagT0Kq6bBnR6PV6FCaHHYjbqKLDnQGHQHGn40K' 'db.admin.password=vault:v1:KiBfAI9929BGzI9en/F77tbkucymwzN/1fKlR0FfxMRZ+8qhRy0f0oETPlgf2K2JjzdzeR0=' 'db.admin.user=einwohner_dev_admin_user'

# read einwohner application properties from vault
./vault read secret/einwohner,dev
