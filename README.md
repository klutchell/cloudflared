# unofficial cloudflared multiarch docker image

[![Docker Pulls](https://img.shields.io/docker/pulls/klutchell/cloudflared.svg?style=flat-square)](https://hub.docker.com/r/klutchell/cloudflared/)
[![Docker Stars](https://img.shields.io/docker/stars/klutchell/cloudflared.svg?style=flat-square)](https://hub.docker.com/r/klutchell/cloudflared/)

[cloudflared](https://github.com/cloudflare/cloudflared) - Cloudflare's command-line tool and agent

## Architectures

The architectures supported by this image are:

- `linux/amd64`
- `linux/arm64`
- `linux/ppc64le`
- `linux/386`
- `linux/arm/v7`
- `linux/arm/v6`

Simply pulling `klutchell/cloudflared` should retrieve the correct image for your arch.

## Build

```bash
# build a local image
docker build . -t klutchell/cloudflared

# cross-build for another platform (eg. arm32v6)
export DOCKER_CLI_EXPERIMENTAL=enabled
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker buildx create --use --driver docker-container
docker buildx build . --platform linux/arm/v6 --load -t klutchell/cloudflared
```

## Test

```bash
# run selftest on local image
docker run --rm -d --name cloudflared klutchell/cloudflared
docker run --rm -it --link cloudflared uzyexe/drill -p 5053 cloudflare.com @cloudflared
docker stop cloudflared
```

## Usage

- Argo Tunnel Documentation: <https://developers.cloudflare.com/argo-tunnel/>
- Running a DNS over HTTPS Client: <https://developers.cloudflare.com/1.1.1.1/dns-over-https/cloudflared-proxy/>

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

## Author

Kyle Harding: <https://klutchell.dev>

## Contributing

Please open an issue or submit a pull request with any features, fixes, or changes.

<https://github.com/klutchell/cloudflared/issues>

## Acknowledgments

Original software is by Cloudflare: <https://github.com/cloudflare/cloudflared>

## License

- klutchell/cloudflared: [MIT License](./LICENSE)
- cloudflare/cloudflared: [CLOUDFLARED LICENSE](https://developers.cloudflare.com/argo-tunnel/license/)
