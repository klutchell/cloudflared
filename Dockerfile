FROM golang:1.12-alpine3.10 as build

WORKDIR /go/src/github.com/cloudflare/cloudflared

ARG CLOUDFLARED_VERSION=2019.10.4
ARG CLOUDFLARED_SOURCE=https://github.com/cloudflare/cloudflared/archive/

ENV CGO_ENABLED 0

RUN apk add --no-cache build-base=0.5-r1 ca-certificates=20190108-r0 curl=7.66.0-r0 upx=3.95-r2 \
	&& curl -L "${CLOUDFLARED_SOURCE}${CLOUDFLARED_VERSION}.tar.gz" -o /tmp/cloudflared.tar.gz \
	&& tar xzf /tmp/cloudflared.tar.gz --strip 1 \
	&& make cloudflared VERSION_FLAGS="-ldflags='-X \"main.Version=$(CLOUDFLARED_VERSION)\" -X \"main.BuildTime=$(date -u '+%Y-%m-%d-%H%M UTC')\" -s -w'" \
	&& upx --brute cloudflared \
	&& adduser -S nonroot

# ----------------------------------------------------------------------------

FROM scratch

ARG BUILD_DATE
ARG BUILD_VERSION
ARG VCS_REF

LABEL org.opencontainers.image.created="${BUILD_DATE}"
LABEL org.opencontainers.image.authors="Kyle Harding <https://klutchell.dev>"
LABEL org.opencontainers.image.url="https://github.com/klutchell/cloudflared"
LABEL org.opencontainers.image.documentation="https://github.com/klutchell/cloudflared"
LABEL org.opencontainers.image.source="https://github.com/klutchell/cloudflared"
LABEL org.opencontainers.image.version="${BUILD_VERSION}"
LABEL org.opencontainers.image.revision="${VCS_REF}"
LABEL org.opencontainers.image.title="klutchell/cloudflared"
LABEL org.opencontainers.image.description="Cloudflare's command-line tool and agent"

COPY --from=build /etc/passwd /etc/passwd
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

COPY --from=build /go/src/github.com/cloudflare/cloudflared/cloudflared /usr/local/bin/

USER nonroot

ENV TUNNEL_DNS_ADDRESS "0.0.0.0"
ENV TUNNEL_DNS_PORT "5053"
ENV TUNNEL_DNS_UPSTREAM "https://1.1.1.1/dns-query,https://1.0.0.1/dns-query"

ENTRYPOINT ["cloudflared", "--no-autoupdate"]

CMD ["proxy-dns"]

RUN ["cloudflared", "--version"]
