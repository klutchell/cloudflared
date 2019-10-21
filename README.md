# unofficial cloudflared multiarch docker image

[![Docker Pulls](https://img.shields.io/docker/pulls/klutchell/cloudflared.svg?style=flat-square)](https://hub.docker.com/r/klutchell/cloudflared/)
[![Docker Stars](https://img.shields.io/docker/stars/klutchell/cloudflared.svg?style=flat-square)](https://hub.docker.com/r/klutchell/cloudflared/)

This image contains the [cloudflared](https://developers.cloudflare.com/argo-tunnel/downloads/) command-line client and its libraries for Argo Tunnel, a tunneling daemon that proxies any local webserver through the Cloudflare network. The [cloudflared](https://developers.cloudflare.com/argo-tunnel/downloads/) client also supports doing DNS over an encrypted HTTPS connection instead of using the default DNS resolver configured for your server/container/VM/environment.

## Tags

- `2019.9.2`, `latest`
- `2019.9.1`

## Architectures

Simply pulling `klutchell/cloudflared` should retrieve the correct image for your arch.

The architectures supported by this image are:

- `linux/amd64`
- `linux/arm64`
- `linux/ppc64le`
- `linux/s390x`
- `linux/386`
- `linux/arm/v7`

## Building

```bash
# print makefile usage
make help

# build and test on the host OS architecture
make build BUILD_OPTIONS=--no-cache

# build multiarch manifest(s) for all supported architectures
make manifest
```

## Usage

Official Argo Tunnel documentation: <https://developers.cloudflare.com/argo-tunnel/>

```bash
# print version info
docker run --rm klutchell/cloudflared version

# print general usage
docker run --rm klutchell/cloudflared --help

# print proxy-dns usage
docker run --rm klutchell/cloudflared proxy-dns --help

# print tunnel usage
docker run --rm klutchell/cloudflared tunnel --help

# run a DNS over HTTPS proxy server on port 53
docker run -p 53:5053/tcp -p 53:5053/udp klutchell/cloudflared proxy-dns
```

## Author

Kyle Harding: <https://klutchell.dev>

## Contributing

Please open an issue or submit a pull request with any features, fixes, or changes.

## Acknowledgments

Original software is by Cloudflare: <https://github.com/cloudflare/cloudflared>

## License

- klutchell/cloudflared: [MIT License](./LICENSE)
- cloudflared: [CLOUDFLARED LICENSE](https://developers.cloudflare.com/argo-tunnel/license/)
