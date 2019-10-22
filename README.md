# unofficial cloudflared multiarch docker image

[![Docker Pulls](https://img.shields.io/docker/pulls/klutchell/cloudflared.svg?style=flat-square)](https://hub.docker.com/r/klutchell/cloudflared/)
[![Docker Stars](https://img.shields.io/docker/stars/klutchell/cloudflared.svg?style=flat-square)](https://hub.docker.com/r/klutchell/cloudflared/)

[cloudflared](https://github.com/cloudflare/cloudflared) - Cloudflare's command-line tool and agent

## Tags

These tags including rolling updates, so occasionally the associated image may change to include fixes.

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
# display available commands
make help

# build and test on the host OS architecture
make build BUILD_OPTIONS=--no-cache

# cross-build multiarch manifest(s) with configured platforms
make all BUILD_OPTIONS=--push

# inspect manifest contents
make inspect
```

## Usage

```bash
# print version info
docker run --rm klutchell/cloudflared --version

# print general usage
docker run --rm klutchell/cloudflared --help

# print proxy-dns usage
docker run --rm klutchell/cloudflared proxy-dns --help

# print tunnel usage
docker run --rm klutchell/cloudflared tunnel --help

# run a DNS over HTTPS proxy server on port 53
docker run -p 53:5053/tcp -p 53:5053/udp klutchell/cloudflared proxy-dns
```

Note that this image is [distroless](https://github.com/GoogleContainerTools/distroless) and contains no shell or busybox binaries.
Logging in to the container is not possible for security reasons.

## Author

Kyle Harding: <https://klutchell.dev>

## Contributing

Please open an issue or submit a pull request with any features, fixes, or changes.

## Acknowledgments

Original software is by Cloudflare: <https://github.com/cloudflare/cloudflared>

## License

- klutchell/cloudflared: [MIT License](./LICENSE)
- cloudflared: [CLOUDFLARED LICENSE](https://developers.cloudflare.com/argo-tunnel/license/)
