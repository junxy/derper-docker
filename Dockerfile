##FROM golang:latest AS builder
ARG ALPINE_VERSION=3.19

# FROM golang:alpine${ALPINE_VERSION} AS builder
# 1-alpine
FROM golang:alpine AS builder
WORKDIR /app

# https://tailscale.com/kb/1118/custom-derp-servers/
RUN go install tailscale.com/cmd/derper@latest

##FROM ubuntu
FROM alpine:${ALPINE_VERSION}
#FROM golang:alpine
WORKDIR /app

##ARG DEBIAN_FRONTEND=noninteractive

#RUN apt-get update && \
#    apt-get install -y --no-install-recommends apt-utils && \
#    apt-get install -y ca-certificates && \
#    mkdir /app/certs

## ref: https://blog.ylx.me/archives/1287.html
#RUN apk add --no-cache ca-certificates iptables ip6tables iproute2 tzdata && \
RUN apk add --no-cache ca-certificates tzdata && \
#    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
#    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata && \
    rm -rf /var/cache/apk/* && \
    mkdir /app/certs

ENV DERP_DOMAIN your-hostname.com
ENV DERP_CERT_MODE letsencrypt
ENV DERP_CERT_DIR /app/certs
ENV DERP_ADDR :443
ENV DERP_STUN true
ENV DERP_STUN_PORT 3478
ENV DERP_HTTP_PORT 80
ENV DERP_VERIFY_CLIENTS false

COPY --from=builder /go/bin/derper .

CMD /app/derper --hostname=$DERP_DOMAIN \
    --certmode=$DERP_CERT_MODE \
    --certdir=$DERP_CERT_DIR \
    --a=$DERP_ADDR \
    --stun=$DERP_STUN  \
    --stun-port=$DERP_STUN_PORT \
    --http-port=$DERP_HTTP_PORT \
    --verify-clients=$DERP_VERIFY_CLIENTS

