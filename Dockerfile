# Shadowsocks Server with KCPTUN support Dockerfile

FROM imhang/shadowsocks-docker

ENV KCP_VER 20170329

RUN \
    apk add --no-cache --virtual .build-deps curl \
    && curl -fSL https://github.com/xtaci/kcptun/releases/download/v$KCP_VER/kcptun-linux-amd64-$KCP_VER.tar.gz | tar xz -C /usr/local/bin server_linux_amd64 \
    && apk del .build-deps \
    && apk add --no-cache supervisor

COPY supervisord.conf /etc/supervisord.conf

ENV KCP_PORT=9443 KCP_KEY=qpzm1258 KCP_CRYPT=none KCP_MODE=manual MTU=1400 SNDWND=512 RCVWND=128 DATASHARD=10 PARITYSHARD=3 NODELAY=1 INTERVAL=40 RESEND=0 NC=1

EXPOSE $KCP_PORT/udp

ENTRYPOINT ["/usr/bin/supervisord"]

