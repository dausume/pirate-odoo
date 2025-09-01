-- pirate-odoo/db/config/init/02-extensions.sql
-- 02 - Extensions for Odoo

-- Run inside the Odoo DB
\connect odoo
-- Enable needed extensions if not already present
CREATE EXTENSION IF NOT EXISTS unaccent;
CREATE EXTENSION IF NOT EXISTS pg_trgm;
