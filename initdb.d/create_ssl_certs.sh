#!/bin/sh

cd "${PGDATA}"

echo
echo "Creating self-signed server certificate..."
echo

openssl req -new -text -nodes -subj "/C=DE/ST=Sachsen/L=Leipzig/O=MPI_EVA/CN=postgres" -out server.req
openssl rsa -in privkey.pem -out server.key && rm privkey.pem
openssl req -x509 -in server.req -text -key server.key -out server.crt
chmod og-rwx server.key
