all: build run

build:
	docker build . --tag docker.io/sirrgb/editors:latest

run:
	docker run --interactive --tty docker.io/sirrgb/editors:latest

publish:
	docker image push docker.io/sirrgb/editors:latest
