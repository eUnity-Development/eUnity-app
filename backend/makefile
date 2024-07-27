


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
	@eval $$(grep -v '^#' .env | sed 's/^/export /') && echo "Loaded environment variables"






 