FROM golang:1.12 as build

WORKDIR ${GOPATH}/src/github.com/cloudflare/cloudflared

ARG CLOUDFLARED_VERSION=2019.10.4
ARG CLOUDFLARED_SOURCE=https://github.com/cloudflare/cloudflared/archive/

ENV DEBIAN_FRONTEND noninteractive
ENV CGO_ENABLED 0

RUN apt-get update && apt-get install -qq --no-install-recommends dnsutils=1:9.11.5.P4+dfsg-5.1 \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
    && curl -L "${CLOUDFLARED_SOURCE}${CLOUDFLARED_VERSION}.tar.gz" -o /tmp/cloudflared.tar.gz \
	&& tar xzf /tmp/cloudflared.tar.gz --strip 1 \
    && make cloudflared VERSION="${CLOUDFLARED_VERSION}" \
    && adduser --system nonroot

# ----------------------------------------------------------------------------

FROM scratch

ARG BUILD_DATE
ARG BUILD_VERSION
ARG VCS_REF

LABEL maintainer="Kyle Harding <https://klutchell.dev>"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="klutchell/cloudflared"
LABEL org.label-schema.description="Cloudflare's command-line tool and agent"
LABEL org.label-schema.url="https://github.com/cloudflare/cloudflared"
LABEL org.label-schema.vcs-url="https://github.com/klutchell/cloudflared"
LABEL org.label-schema.docker.cmd="docker run --rm klutchell/cloudflared --help"
LABEL org.label-schema.build-date="${BUILD_DATE}"
LABEL org.label-schema.version="${BUILD_VERSION}"
LABEL org.label-schema.vcs-ref="${VCS_REF}"

COPY --from=build /go/src/github.com/cloudflare/cloudflared/cloudflared /usr/local/bin/cloudflared
COPY --from=build /etc/passwd /etc/passwd
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /usr/bin/dig /usr/bin/dig

USER nonroot

ENV TUNNEL_DNS_ADDRESS="0.0.0.0"
ENV TUNNEL_DNS_PORT="5053"

ENTRYPOINT ["cloudflared", "--no-autoupdate"]

CMD ["proxy-dns"]

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
	CMD [ "dig", "+short", "@127.0.0.1", "-p", "5053", "cloudflare.com", "AAAA" ]

RUN ["cloudflared", "--version"]
