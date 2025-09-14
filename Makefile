all: build run

build:
	docker build . --tag sirrgb/editors

run:
	docker run --interactive --tty sirrgb/editors

publish:
	docker push sirrgb/editors
