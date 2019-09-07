# Write einwohner application properties in vault
./vault write secret/einwohner,dev 'spring.datasource.url=jdbc:mysql://192.168.2.108:3306/einwohner_dev?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC' 'spring.datasource.username=einwohner_dev_app_user' 'spring.datasource.password={cipher}AQBtt4M2p3n/avucbcIi1sP1eapgMj4Weux0wtMz7HUAWW6K84qZuPcmUuq8RiSL179+fRXmuJEyVF4mc8J1w2mT0/IULPwueRpZyv8cjGLYLk+N9HLaAjvRdxihXaZz/jKOZbV3DrPGbtIgrieyt1XdVp49CobRjJ4o5q8omHXbB9Y4lW1puDqLz0zL3TABTlawGiGuZ3F3rw/iPBIvCvMDgKI7NNw/iPSj8mLrkbwvEBsa34V+9TNeEJ8v/UZ3cVJa1kQok8KBrvVU8UBQhK28MBpGqoELGgsaEkNHbP/1iUPd55pVHK4A4kpftgZUFX+02r1iesUtDVnUkZfOZIwnlf3WZkysQYa52MwkkAOeaHR4WjOWYgvwyOq/ce/bNWgVtpB/E7f1W0XG4Xmdf8OG' 'db.admin.user=einwohner_dev_admin_user' 'db.admin.password={cipher}AQCk8IJ/zLt2biENSQTZuYJvLgnZuQb6OdNl0nxo44UIoUF48Uk4NurxEVC1dierFkZcYJVwTYWiqHNtAtiBjBteswBmSjrIVMXwZnrymwLigtBYMf0wQBWuISJCQgzDmVI5qEAGdUvRXfUTr+t/fQOO39ffqg3qdtZ9bn82tpmJCMiz9fwzTlfGC4YLfc3ChA/T95E7wwxoTK827O+2cUGRRcBbXRqpef5BkJxkLGT5yZCB25nFlQjcpI1hquw2qtkekzB0JHXQWS1w/XfKBCHzNRIr8WRnENwB7wf6cCMn4CNDiVHYVwlP/kMpgdnHfqFibM+bPQmtziUsFW2VBdhhdft4+mF9DCCvSdlCb1chbG5+mxPmQAUS0seo5+UIOZ7LHqIyOrZCwv6dysBsJ6ip'

# read einwohner application properties from vault
./vault read secret/einwohner,dev