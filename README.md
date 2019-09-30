# unofficial cloudflared docker image

[![Docker Pulls](https://img.shields.io/docker/pulls/klutchell/cloudflared.svg?style=flat-square)](https://hub.docker.com/r/klutchell/cloudflared/)
[![Docker Stars](https://img.shields.io/docker/stars/klutchell/cloudflared.svg?style=flat-square)](https://hub.docker.com/r/klutchell/cloudflared/)

This image contains the [cloudflared](https://developers.cloudflare.com/argo-tunnel/downloads/) command-line client and its libraries for Argo Tunnel, a tunneling daemon that proxies any local webserver through the Cloudflare network. The [cloudflared](https://developers.cloudflare.com/argo-tunnel/downloads/) client also supports doing DNS over an encrypted HTTPS connection instead of using the default DNS resolver configured for your server/container/VM/environment.

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
# run a DNS over HTTPS proxy server on port 53
docker run -p 53:5053/udp klutchell/cloudflared proxy-dns
```

## Building

```bash
# print makefile usage
make help

# ARCH can be amd64, arm32v6, arm32v7, arm64v8, i386, ppc64le, s390x
# and is emulated on top of any host architechture with qemu
make build ARCH=arm32v6

# appending -all to the make target will run the task
# for all supported architectures and may take a long time
make build-all BUILD_OPTIONS=--no-cache
```

## Usage

The [cloudflared](https://developers.cloudflare.com/argo-tunnel/downloads/) service supports multiple advanced/paid features
such as [Argo Tunnel](https://developers.cloudflare.com/argo-tunnel/),
however this README only covers basic [DNS over HTTPS](https://developers.cloudflare.com/argo-tunnel/reference/doh/) proxy.

You can print the full command-line usage options by running the container.

```bash
# print general usage
docker run --rm klutchell/cloudflared --help

# print proxy-dns usage
docker run --rm klutchell/cloudflared proxy-dns --help

# print tunnel usage
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
- cloudflared: [CLOUDFLARED LICENSE](https://developers.cloudflare.com/argo-tunnel/license/)
