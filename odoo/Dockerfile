FROM odoo:17.0

# Temporarily switch to root to install packages and make permission changes
USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl nano && rm -rf /var/lib/apt/lists/*

# Ship the entrypoint script that sets up Odoo configuration and other things
COPY shells/odoo-entrypoint.sh /usr/local/bin/odoo-entrypoint.sh
RUN chmod +x /usr/local/bin/odoo-entrypoint.sh

# (Optional) seed initial filestore content (FIRST RUN of named volume only)
# NOTE: path must be relative to the build context, no leading slash
COPY file-storage/ /var/lib/odoo/

# Ensure paths exist and are owned correctly in the image layer
RUN mkdir -p /var/lib/odoo/sessions /var/log/odoo /etc/odoo \
 && chown -R odoo:odoo /var/lib/odoo /var/log/odoo /etc/odoo



# Switch back to the odoo user, to prevent any security vulnearbilities that can be exploited by hackers.
# odoo is a user created with just sufficient permissions to run the Odoo application.
USER odoo

# Entrypoint and command are set in docker-compose.yml to allow custom config