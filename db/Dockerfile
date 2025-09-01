FROM postgres:15

RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql-contrib curl && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/postgresql/conf.d /docker-entrypoint-initdb.d
COPY ./shells/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Entrypoint and command are set in docker-compose.yml to allow custom config