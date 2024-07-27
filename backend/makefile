


include .env
export

run: load_env compose get_packages swag 
	air

serve: compile
	./main


compile: get_packages

	@go build  -o main

get_packages:
	@go get

swag:
	swag init

compose:
	docker compose up -d



load_env:
	@echo "Loading environment variables from .env"
	@bash -c 'set -a && . .env && set +a && echo "HOST_WORKING_DIR=$$HOST_WORKING_DIR"'







 