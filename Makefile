.PHONY: build push test

build:
	docker build -t portalsinc/openstreetmap-tile-server .

push: build
	docker push portalsinc/openstreetmap-tile-server:latest

test: build
	docker volume create openstreetmap-data
	docker run -v openstreetmap-data:/var/lib/postgresql/10/main portalsinc/openstreetmap-tile-server import
	docker run -v openstreetmap-data:/var/lib/postgresql/10/main -p 80:80 -d portalsinc/openstreetmap-tile-server run