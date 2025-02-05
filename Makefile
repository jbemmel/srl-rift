NAME        := srl/openrift
LAST_COMMIT := $(shell sh -c "git log -1 --pretty=%h")
TODAY       := $(shell sh -c "date +%Y%m%d_%H%M")
TAG         := ${TODAY}.${LAST_COMMIT}
IMG         := ${NAME}:${TAG}
LATEST      := ${NAME}:latest
# HTTP_PROXY  := "http://proxy.server.com:8000"

ifndef SR_LINUX_RELEASE
override SR_LINUX_RELEASE="latest"
endif

build:
	sudo DOCKER_BUILDKIT=1 docker build --build-arg SRL_OPENRIFT_RELEASE=${TAG} \
	   --build-arg http_proxy=${HTTP_PROXY} --build-arg https_proxy=${HTTP_PROXY} \
	   --build-arg SR_LINUX_RELEASE="${SR_LINUX_RELEASE}" \
	   -f ./Dockerfile -t ${IMG} .
	sudo docker tag ${IMG} ${LATEST}
