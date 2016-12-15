MyPg
====

Postgres in a Docker container, built from source and set up the way I like / need it.

Many bits “borrowed” from the
[official Postgres Docker container](https://hub.docker.com/_/postgres/)!

Compiled with support for:

* libxml2
* openssl
* PL/Python (Python 2.7)

Included plugins:

* Standard (contrib) plugins:
    - adminpack
    - pgcrypto

* 3rd party plugins:
    - Multicorn (my own fork without filehandle cache)
    - [psql-http](https://github.com/pramsey/pgsql-http)

> *Note:*  This is really for my own use.  Some bits may be specific to the
  setup at MPI EVA.  That said, the `Dockerfile` should be pretty generic and
  usable for anyone who wants to containerise a bespoke, hand-built Postgres.
