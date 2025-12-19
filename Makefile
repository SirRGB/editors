all: build run

build:
	docker build . --tag docker.io/sirrgb/editors:latest

run:
	docker run --interactive --tty docker.io/sirrgb/editors:latest

publish:
	docker tag docker.io/sirrgb/editors:latest docker.io/sirrgb/editors:$$(date +%Y%m%d%H%M)
	docker image push docker.io/sirrgb/editors:$$(date +%Y%m%d%H%M)
	docker image push docker.io/sirrgb/editors:latest
