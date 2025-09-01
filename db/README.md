# To get /config/init/*.sql & *.sh files to run, clear out data and volumes
docker compose down --volumes --remove-orphans
sudo rm -rf ./db/data/*
docker compose up -d db
docker compose logs -f db

# List all roles (users)
sudo docker compose exec -u postgres db psql -d postgres -c "\du+"

# Check databases that exist and what user is their corresponding DBA
sudo docker compose exec -u postgres db psql -d postgres -c "SELECT datname, datdba::regrole FROM pg_database;"

# Create a role with LOGIN + password

    sudo docker compose exec -u postgres db psql -d postgres -c "CREATE ROLE \"odoo-server\" WITH LOGIN PASSWORD 'password';"

# If you want it to be a superuser (for Odoo bootstrap):
sudo docker compose exec -u postgres db psql -d postgres -c "ALTER ROLE \"odoo-server\" WITH SUPERUSER;"

# Create the odoo database, and assign the odoo-server role as the owner of it.
sudo docker compose exec -u postgres db psql -d postgres -c "CREATE DATABASE odoo OWNER \"odoo-server\";"

# Confirm the odoo database is owned by "odoo-server"
sudo docker compose exec -u postgres db psql -d postgres -c "SELECT datname, datdba::regrole FROM pg_database WHERE datname='odoo';"
