.PHONY: build upload

build:
	hugo
	docker build -t git.efym.net/tw1zr/efym.net:latest -f docker/Dockerfile .

upload: build
	docker push git.efym.net/tw1zr/efym.net:latest
