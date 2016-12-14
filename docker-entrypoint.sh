#!/bin/bash

set -e

if [ "$1" = 'postgres' ]; then
    chown -R postgres "$PGDATA"

    if [ ! -s "${PGDATA}/PG_VERSION" ]; then
        gosu postgres initdb -E UTF8 --locale=en_US.utf8
    fi

    exec gosu postgres "$@"
fi

exec "$@"
