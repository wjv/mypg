MyPg
====

Postgres in a Docker container, built from source and set up the way I like / need it.

This repository is used to build images on [Docker Hub](https://hub.docker.com/r/visagie/mypg/)
and [Docker Cloud](https://cloud.docker.com/swarm/visagie/repository/docker/visagie/mypg/general).

Some bits “borrowed” from the
[official Postgres Docker container](https://hub.docker.com/_/postgres/)!

Compiled with support for:

* libxml2
* openssl
* LDAP
* PL/Python (Python 2.7)

Included plugins:

* Standard (contrib) plugins:
    - adminpack
    - pgcrypto

* 3rd party plugins:
    - Multicorn (my own fork without filehandle cache)
    - [psql-http](https://github.com/pramsey/pgsql-http)

> *Note:*  This is really for my own use, set up to my own requirements.  That said,
  I think it's a reasonable example of a hand-built Postgres container, and could be
  generally useful.
