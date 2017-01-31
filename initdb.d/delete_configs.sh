#!/bin/sh

cd "${PGDATA}"

echo
echo "Deleting default configuration files..."
echo

for fn in postgresql.conf pg_hba.conf pg_ident.conf; do
  rm -vf ${fn}
done
