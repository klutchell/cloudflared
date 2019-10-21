FROM golang:1.12 as builder

ARG CLOUDFLARED_BRANCH="2019.9.2"
ARG CLOUDFLARED_URL="https://github.com/cloudflare/cloudflared"

RUN git clone --depth 1 --branch ${CLOUDFLARED_BRANCH} ${CLOUDFLARED_URL} "${GOPATH}/src/github.com/cloudflare/cloudflared"

WORKDIR ${GOPATH}/src/github.com/cloudflare/cloudflared

RUN make cloudflared

# ----------------------------------------------------------------------------

FROM gcr.io/distroless/base

ARG BUILD_DATE
ARG BUILD_VERSION
ARG VCS_REF

LABEL maintainer="Kyle Harding <https://klutchell.dev>"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="klutchell/cloudflared"
LABEL org.label-schema.description="Argo Tunnel client"
LABEL org.label-schema.url="https://github.com/cloudflare/cloudflared"
LABEL org.label-schema.vcs-url="https://github.com/klutchell/cloudflared"
LABEL org.label-schema.docker.cmd="docker run --rm klutchell/cloudflared --help"
LABEL org.label-schema.build-date="${BUILD_DATE}"
LABEL org.label-schema.version="${BUILD_VERSION}"
LABEL org.label-schema.vcs-ref="${VCS_REF}"

COPY --from=builder /go/src/github.com/cloudflare/cloudflared/cloudflared /usr/local/bin/cloudflared

ENTRYPOINT ["cloudflared", "--no-autoupdate"]

CMD ["--help"]