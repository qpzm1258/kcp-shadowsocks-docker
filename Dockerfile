# Shadowsocks Server with KCPTUN support Dockerfile

FROM imhang/shadowsocks-docker

ENV KCP_VER 20170329

RUN \
    apk add --no-cache --virtual .build-deps curl \
    && curl -fSL https://github.com/xtaci/kcptun/releases/download/v$KCP_VER/kcptun-linux-amd64-$KCP_VER.tar.gz | tar xz -C /usr/local/bin server_linux_amd64 \
    && apk del .build-deps \
    && apk add --no-cache supervisor

COPY supervisord.conf /etc/supervisord.conf

ENV KCP_PORT=29900 KCP_KEY=qpzm1258 KCP_CRYPT=none KCP_MODE=manual MTU=1400 SNDWND=1024 RCVWND=1024 DATASHARD=10 PARITYSHARD=3 KCP_NODELAY=1 KCP_INTERVAL=40 KCP_RESEND=0 KCP_NC=1

EXPOSE $KCP_PORT/udp

ENTRYPOINT ["/usr/bin/supervisord"]

