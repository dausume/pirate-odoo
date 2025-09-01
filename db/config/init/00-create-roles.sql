-- pirate-odoo/db/config/init/00-create-roles.sql
-- 00 - Create Roles and Databases for Odoo
-- Superuser role for Odoo application
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'odoo-server') THEN
    CREATE ROLE "odoo-server" WITH LOGIN SUPERUSER PASSWORD 'password';
  END IF;
END$$;
