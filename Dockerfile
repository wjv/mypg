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
      libcurl4-openssl-dev \
      libreadline-dev \
      libssl-dev \
      libxml2-dev \
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
    PGHTTP_VERSION=1.1.2 \
    PGDATA=/data

RUN mkdir /src \
    && curl -s \
      https://ftp.postgresql.org/pub/source/v${PG_VERSION}/postgresql-${PG_VERSION}.tar.bz2 \
      | tar xvjC /src \
    && cd /src/postgresql-${PG_VERSION} \
    && ./configure \
      --with-openssl \
      --with-libxml \
      --enable-thread-safety \
      --with-python \
      --prefix=/usr/local \
    && make install \
    && make install -C contrib/adminpack \
    && make install -C contrib/pgcrypto

RUN curl -sL \
      https://github.com/pramsey/pgsql-http/archive/v${PGHTTP_VERSION}.tar.gz \
      | tar xvzC /src \
    && cd /src/pgsql-http-${PGHTTP_VERSION} \
    && make install

COPY requirements.txt *.sh /

RUN pip install --upgrade --no-cache-dir pip setuptools wheel \
    && pip install --no-cache-dir -r /requirements.txt

RUN git clone https://github.com/wjv/Multicorn.git -b nocache /src/Multicorn \
    && cd /src/Multicorn \
    && make install

RUN groupadd -r postgres --gid=999 && useradd -r -g postgres --uid=999 postgres

RUN sed -i -e '/^xterm/{' -e 'n; s/^/#/' -e '}' /root/.bashrc

RUN apt-get purge -y --auto-remove ca-certificates \
      build-essential \
      bzip2 \
      curl \
      git \
    && rm -rf /src /requirements.txt

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 5432

CMD ["postgres"]
