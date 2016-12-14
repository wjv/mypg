#!/bin/bash

set -e

if [ "$1" = 'postgres' ]; then
    chown -R postgres "$PGDATA"

    if [ ! -s "${PGDATA}/PG_VERSION" ]; then
        gosu postgres initdb 
    fi

    exec gosu postgres "$@"
fi

exec "$@"
