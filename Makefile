
DOCKER_REPO := klutchell/cloudflared
TAG := 2019.9.2
BUILD_OPTIONS +=

BUILD_DATE := $(strip $(shell docker run --rm busybox date -u +'%Y-%m-%dT%H:%M:%SZ'))
BUILD_VERSION := ${TAG}-$(strip $(shell git describe --tags --always --dirty))
VCS_REF := $(strip $(shell git rev-parse HEAD))

DOCKER_CLI_EXPERIMENTAL := enabled

.EXPORT_ALL_VARIABLES:

.DEFAULT_GOAL := build

.PHONY: build manifest help

build: builder ## build and test on the host OS architecture
	docker buildx build ${BUILD_OPTIONS} --pull --load \
		--build-arg BUILD_VERSION \
		--build-arg BUILD_DATE \
		--build-arg VCS_REF \
		--tag ${DOCKER_REPO} .
	docker run --rm ${DOCKER_REPO}

manifest: builder ## build multiarch manifest(s) for all supported architectures
	docker buildx build ${BUILD_OPTIONS} --pull --push \
		--platform linux/amd64,linux/arm64,linux/ppc64le,linux/s390x,linux/386,linux/arm/v7 \
		--build-arg BUILD_VERSION \
		--build-arg BUILD_DATE \
		--build-arg VCS_REF \
		--tag ${DOCKER_REPO}:latest \
		--tag ${DOCKER_REPO}:${TAG} .

builder: binfmt
	-docker buildx create --use --name ci

binfmt:
	docker run --rm --privileged docker/binfmt:66f9012c56a8316f9244ffd7622d7c21c1f6f28d

help: ## display available commands
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
