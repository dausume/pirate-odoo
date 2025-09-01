-- pirate-odoo/db/config/init/01-databases.sql
-- 01 - Create the main Odoo database and any other needed databases
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'odoo') THEN
    CREATE DATABASE odoo OWNER "odoo-server";
  END IF;
END$$;
