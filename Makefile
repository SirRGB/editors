all: build run

build:
	docker build . -t editors

run:
	docker run -i -t editors
