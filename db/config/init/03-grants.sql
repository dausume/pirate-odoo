-- pirate-odoo/db/config/init/03-grants.sql
-- 03 - Grants and Ownerships
-- Ensure the odoo role owns what it needs
\connect odoo
-- Change ownership of public schema to odoo-server role
ALTER SCHEMA public OWNER TO "odoo-server";
GRANT ALL ON SCHEMA public TO "odoo-server";

