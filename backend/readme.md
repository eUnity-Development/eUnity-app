# Go Back End



Front-end Devs run the backend like this:

    make serve



For live reloading run the following to install packages:
    
    go get

Then run this for live reloading: 
    
    air

Alternatively you can use the makefile
    
    make run


Must add export PATH=$(go env GOPATH)/bin:$PATH to path

Must also install air, and swag

go install github.com/cosmtrek/air@latest

go install github.com/swaggo/swag/cmd/swag@latest


resources : 
    
    https://github.com/cosmtrek/air

    https://github.com/swaggo/gin-swagger

