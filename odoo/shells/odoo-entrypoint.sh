#!/usr/bin/env bash
set -euo pipefail

# Make sure sessions dir exists (named volume will already be owned by 'odoo')
mkdir -p /var/lib/odoo/sessions
chmod 700 /var/lib/odoo/sessions || true

# Run the command passed from docker-compose (e.g., /usr/bin/odoo -c ...)
exec "$@"
