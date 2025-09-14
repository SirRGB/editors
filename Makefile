all: build run

build:
	docker build . --tag editors

run:
	docker run --interactive --tty editors
