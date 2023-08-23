.PHONY: build upload

build:
	hugo
	docker build -t gitea.efym.net/tw1zr/efym.net:latest -f docker/Dockerfile .

upload: build
	docker push gitea.efym.net/tw1zr/efym.net:latest
