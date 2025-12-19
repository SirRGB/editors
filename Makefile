all: build run

build:
	docker build . --tag docker.io/sirrgb/editors:latest

run:
	docker run --interactive --tty docker.io/sirrgb/editors:latest

publish:
	tag ?= $$(date +%Y%m%d%H%M)
	docker tag docker.io/sirrgb/editors:latest docker.io/sirrgb/editors:$tag
	docker image push docker.io/sirrgb/editors:$tag
	docker image push docker.io/sirrgb/editors:latest
