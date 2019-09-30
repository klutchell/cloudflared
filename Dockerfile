
ARG ARCH=amd64

# ----------------------------------------------------------------------------

FROM ${ARCH}/golang:1.13.1-alpine3.10 as cloudflared

ENV CLOUDFLARED_BRANCH="2019.9.1"
ENV CLOUDFLARED_URL="https://github.com/cloudflare/cloudflared"

RUN apk add --no-cache build-base=0.5-r1 ca-certificates=20190108-r0 gcc=8.3.0-r0 git=2.22.0-r0 \
	&& git -c advice.detachedHead=false clone --depth 1 --branch ${CLOUDFLARED_BRANCH} ${CLOUDFLARED_URL} "${GOPATH}/src/github.com/cloudflare/cloudflared"

WORKDIR ${GOPATH}/src/github.com/cloudflare/cloudflared

RUN make cloudflared

# ----------------------------------------------------------------------------

FROM ${ARCH}/alpine:3.10.2

ARG BUILD_DATE
ARG BUILD_VERSION
ARG VCS_REF

LABEL maintainer="Kyle Harding <https://klutchell.dev>"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="klutchell/cloudflared"
LABEL org.label-schema.description="Argo Tunnel client"
LABEL org.label-schema.url="https://github.com/cloudflare/cloudflared"
LABEL org.label-schema.vcs-url="https://github.com/klutchell/cloudflared"
LABEL org.label-schema.docker.cmd="docker run -p 53:5053/udp klutchell/cloudflared"
LABEL org.label-schema.build-date="${BUILD_DATE}"
LABEL org.label-schema.version="${BUILD_VERSION}"
LABEL org.label-schema.vcs-ref="${VCS_REF}"

COPY --from=cloudflared /go/src/github.com/cloudflare/cloudflared/cloudflared /usr/local/bin/cloudflared

RUN apk add --no-cache ca-certificates=20190108-r0 drill=1.7.0-r2 libressl=2.7.5-r0 shadow=4.6-r2 tzdata=2019b-r0 \
	&& addgroup -g 1000 cloudflared && adduser -u 1000 -D -H -s /sbin/nologin -G cloudflared cloudflared \
	&& cloudflared --version

USER cloudflared

ENV TUNNEL_DNS_ADDRESS="0.0.0.0"
ENV TUNNEL_DNS_PORT="5053"
ENV TUNNEL_DNS_UPSTREAM="https://1.1.1.1/dns-query,https://1.0.0.1/dns-query"

EXPOSE 5053/udp

HEALTHCHECK --interval=5s --timeout=3s --start-period=5s \
	CMD drill -p 5053 cloudflare.com @127.0.0.1 || exit 1

ENTRYPOINT [ "/usr/local/bin/cloudflared" ]

CMD [ "proxy-dns" ]