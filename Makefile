.PHONY: build upload

build:
	hugo
	docker build -t codeberg.org/tw1zr/efym.net:latest -f docker/Dockerfile .

upload: build
	docker push codeberg.org/tw1zr/efym.net:latest
