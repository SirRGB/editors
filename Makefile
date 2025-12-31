all: build run
tag ?= $$(date +%Y%m%d%H%M)

build:
	docker build . --tag docker.io/sirrgb/editors:latest

run:
	docker run --interactive --tty docker.io/sirrgb/editors:latest

publish:
	docker tag docker.io/sirrgb/editors:latest docker.io/sirrgb/editors:$(tag)
	docker image push docker.io/sirrgb/editors:$(tag)
	docker image push docker.io/sirrgb/editors:latest
