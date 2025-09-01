# Configuring Odoo Docker Image to enable custom scripts on startup via odoo-shell
## Official Docs
https://www.odoo.com/documentation/18.0/developer/reference/cli.html#shell

# To initialize the odoo db manually
sudo docker compose exec odoo /usr/bin/odoo -c /etc/odoo/.odoorc -d odoo -i base --without-demo=all --stop-after-init

# Set admin user manually.
sudo docker compose exec -u postgres db psql -d odoo -c \
"UPDATE res_users SET password='mynewpassword' WHERE login='admin';"
