FROM ubuntu:latest

MAINTAINER Johann Visagie, johann@visagie.za.net

RUN set -x \
    && apt-get -y update \
    && apt-get install -y --no-install-recommends ca-certificates \
      build-essential \
      bzip2 \
      git \
      gosu \
      curl \
      libreadline-dev \
      libssl-dev \
      locales \
      python \
      python-dev \
      python-pip \
      zlib1g-dev \
  && rm -rf /var/lib/apt/lists/* \
  && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG=en_US.utf8 \
    PG_MAJOR=9.6 \
    PG_VERSION=9.6.1 \
#    LC_ALL=C \
    PGDATA=/data

RUN mkdir /src \
    && curl -s \
      https://ftp.postgresql.org/pub/source/v${PG_VERSION}/postgresql-${PG_VERSION}.tar.bz2 \
      | tar xvjC /src \
    && cd /src/postgresql-${PG_VERSION} \
    && ./configure \
      --with-openssl \
      --enable-thread-safety \
      --with-python \
      --prefix=/usr/local \
    && make install

COPY requirements.txt *.sh /

RUN pip install --upgrade --no-cache-dir pip setuptools wheel \
    && pip install --no-cache-dir -r /requirements.txt

RUN groupadd -r postgres --gid=999 && useradd -r -g postgres --uid=999 postgres

RUN apt-get purge -y --auto-remove ca-certificates \
      build-essential \
      bzip2 \
      curl \
      git \
    && rm -rf /src /requirements.txt /root/.bashrc

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432

CMD ["postgres"]
