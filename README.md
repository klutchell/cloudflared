# unofficial cloudflared docker image

<a href="https://github.com/klutchell/cloudflared/actions"><img src="https://github.com/klutchell/cloudflared/workflows/build/badge.svg" alt="Build Status"></a>
<a href="https://hub.docker.com/r/klutchell/cloudflared/"><img src="https://img.shields.io/docker/stars/klutchell/cloudflared.svg?style=flat-square" alt="Docker Stars"></a>
<a href="https://hub.docker.com/r/klutchell/cloudflared/"><img src="https://img.shields.io/docker/pulls/klutchell/cloudflared.svg?style=flat-square" alt="Docker Pulls"></a>

[Argo Tunnel client](https://github.com/cloudflare/cloudflared) contains the command-line client (`cloudflared`) and its libraries for Argo Tunnel, a tunneling daemon that proxies any local webserver through the Cloudflare network. The `cloudflared` client also supports doing DNS over an encrypted HTTPS connection instead of using the default DNS resolver configured for your server/container/VM/environment.

## Tags

- `latest`, `2019.9.1`
- `amd64-latest`, `amd64-2019.9.1`
- `arm32v6-latest`, `arm32v6-2019.9.1`
- `arm32v7-latest`, `arm32v7-2019.9.1`
- `arm64v8-latest`, `arm64v8-2019.9.1`
- `i386-latest`, `i386-2019.9.1`
- `ppc64le-latest`, `ppc64le-2019.9.1`
- `s390x-latest`, `s390x-2019.9.1`

## Deployment

```bash
docker run -p 53:5053/udp -p 49312/tcp klutchell/cloudflared
```

## Parameters

- `-p 53:5053/udp` - publish udp port 5053 on the container to udp port 53 on the host for [DNS over HTTPS](https://developers.cloudflare.com/argo-tunnel/reference/doh/)
- `-p 49312:49312/tcp` - (optional) publish tcp port 49312 on the container to tcp port 49312 on the host for metrics reporting
- `-e TZ=America/Toronto` - (optional) provide a timezone for the container from this [list of TZ timezones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)
- `-e TUNNEL_DNS_UPSTREAM=https://1.1.1.1/dns-query,https://1.0.0.1/dns-query` - (optional) upstream endpoint URL

Environment variables for Argo Tunnel: <https://developers.cloudflare.com/argo-tunnel/reference/arguments/>

## Building

```bash
# ARCH can be amd64, arm32v6, arm32v7, arm64v8, i386, ppc64le, s390x
# and is emulated on top of any host architechture with qemu
make build ARCH=arm32v6

# appending -all to the make target will run the task
# for all supported architectures and may take a long time
make build-all BUILD_OPTIONS=--no-cache

# run `make help` for a complete list of make targets
```

## Usage

- Argo Tunnel: <https://developers.cloudflare.com/argo-tunnel/quickstart/>
- DNS over HTTPS: <https://developers.cloudflare.com/argo-tunnel/reference/doh/>

You can print the command-line help options by running the container.

```bash
docker run --rm klutchell/cloudflared --help
docker run --rm klutchell/cloudflared proxy-dns --help
docker run --rm klutchell/cloudflared tunnel --help
```

## Author

Kyle Harding: <https://klutchell.dev>

## Contributing

Please open an issue or submit a pull request with any features, fixes, or changes.

## Acknowledgments

This image is largely based on CrazyMax's work: <https://github.com/crazy-max/docker-cloudflared>

## License

- klutchell/cloudflared: [MIT License](./LICENSE)
- cloudflared: [LICENSE](https://github.com/cloudflare/cloudflared/blob/master/LICENSE)
