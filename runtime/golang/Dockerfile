FROM debian:stretch-slim

ENV TZ=Asia/Shanghai
ENV PATH=/app/bin/:$PATH

COPY sources.list /etc/apt/
COPY golang/docker-entrypoint.sh /usr/local/bin/

RUN set -eux && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      g++ \
      git \
      make \
      ca-certificates && \
    git clone https://github.com/rofl0r/proxychains-ng.git && \
    cd proxychains-ng && \
    ./configure --prefix=/usr --sysconfdir=/etc && \
    make && make install && make install-config && \
    cd .. && rm -rf proxychains-ng /var/lib/apt/lists/*

ENTRYPOINT ["docker-entrypoint.sh"]

WORKDIR /app/bin/
