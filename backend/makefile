

run: get_packages swag
	air

serve: compile
	./main


compile: get_packages

	@go build main.go

get_packages:
	@go get

swag:
	swag init