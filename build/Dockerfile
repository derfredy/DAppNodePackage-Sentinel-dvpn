FROM golang:alpine3.13 AS build

RUN apk add git gcc linux-headers make musl-dev && \
    mkdir -p /go/src/github.com/sentinel-official/ && \
    cd /go/src/github.com/sentinel-official/ && \
    git clone https://github.com/sentinel-official/dvpn-node.git && \
    cd /go/src/github.com/sentinel-official/dvpn-node/ && \
    git checkout master && \
    make install --jobs=$(nproc)

RUN cd /root/ && \
    apk add autoconf automake file g++ git libtool make unbound-dev && \
    git clone https://github.com/handshake-org/hnsd.git --branch=v1.0.0 --depth=1 && \
    cd /root/hnsd/ && \
    bash autogen.sh && sh configure && make --jobs=$(nproc)

FROM alpine:3.13

COPY --from=build /go/bin/sentinelnode /usr/local/bin/process
COPY --from=build /root/hnsd/hnsd /usr/local/bin/hnsd

RUN apk add --no-cache ip6tables unbound-dev wireguard-tools openssl curl vim && \
    rm -rf /tmp/* /var/tmp/*

ADD config.toml entrypoint.sh /root/

EXPOSE 19192/udp 8585

ENTRYPOINT /root/entrypoint.sh
