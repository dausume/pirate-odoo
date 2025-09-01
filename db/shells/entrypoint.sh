#!/usr/bin/env bash
set -euo pipefail

PGDATA="${PGDATA:-/var/lib/postgresql/data}"
CONF_MAIN="/etc/postgresql/postgresql.conf"
CONF_HBA="/etc/postgresql/pg_hba.conf"
CONF_DIR="/etc/postgresql/conf.d"

BIN_INITDB="$(command -v initdb)"
BIN_PG_CTL="$(command -v pg_ctl)"
BIN_PSQL="$(command -v psql)"

if [ ! -x "$BIN_INITDB" ] || [ ! -x "$BIN_PG_CTL" ] || [ ! -x "$BIN_PSQL" ]; then
  echo "[db] ERROR: postgres binaries not found" >&2
  exit 127
fi

if [ ! -s "$PGDATA/PG_VERSION" ]; then
  echo "[db] initializing cluster at $PGDATA ..."
  mkdir -p "$PGDATA"
  chown -R postgres:postgres "$PGDATA"
  chmod 700 "$PGDATA"
  su -s /bin/bash postgres -c "$BIN_INITDB -D '$PGDATA'"

  echo "[db] starting temporary postmaster ..."
  su -s /bin/bash postgres -c "$BIN_PG_CTL -D '$PGDATA' -o \"-c config_file=$CONF_MAIN -c hba_file=$CONF_HBA -c include_dir=$CONF_DIR\" -w start"

  if ls /docker-entrypoint-initdb.d/* >/dev/null 2>&1; then
    for f in /docker-entrypoint-initdb.d/*; do
      case "$f" in
        *.sh)  echo "[db] running $f"; bash "$f" ;;
        *.sql) echo "[db] running $f"; su -s /bin/bash postgres -c "$BIN_PSQL -v ON_ERROR_STOP=1 -f '$f'" ;;
        *)     echo "[db] ignoring $f" ;;
      esac
    done
  fi

  echo "[db] stopping temporary postmaster ..."
  su -s /bin/bash postgres -c "$BIN_PG_CTL -D '$PGDATA' -m fast -w stop"
fi

echo "[db] launching postgres ..."
exec su -s /bin/bash postgres -c "$*"
