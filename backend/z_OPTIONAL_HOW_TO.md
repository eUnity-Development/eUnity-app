# Update how to run backend(optional)


If you are currently onboarding, it is strongly recommended you use the regular 
dev containers method to run the backend It requires zero dependencies other than docker. 

If running on a weak machine you may follow the information here. You will need to manually set up swag, air, make, golang, and mongodb, along with any other dev dependency that comes included in the dev container. 

I will no be providing instructions for those steps here. 

Although docker dev containers ensure a uniform dev experience there is slight overhead to running docker. On linux docker does no virtualization and it is essentially just namespacing on steroids.

Overhead is more significant on windows since docker is required to run on top of wsl and use virtualization.

For this reason, It seems wise we separate the image processing since it is the only
part of the code that requires an enviroment dependecy other than go. 


## What is required for development

Valkey/redis is only used by sessionManager and it auto defaults to using mongo if redis can not connect. In most cases there is no real reason to have a redis instance running during development, and it makes it easier to delete sessions from mongodb compass. 


The only hard enviroment dependency we need outside of golang is vips. We can remove this dependency by separating the image handler code into it's own seperate microservice. It should basically be our own shitty image kit. I am considering using https://immich.app/ as a gui for us to manage the server images. 


Since the image handler will be a microservice we can only use it while deployed.
This is good practice for deployments and figuring out tooling for managing images. 


The media encoder api will be left exactly the same, but media encoder will simply make requests to the microservice during dev. So we will be experiencing more realistic load times as well. For production, backend will use an internal url. 



### Dev Containers

    Regular dev containers still work exactly the same. I might mess around with making the dev eviroment containers much lighter and polishing the tutorial and overall process.


## Now available

    Since the vips requirement has been separated you can once again run go directly with no issues.
    ```go run main.go```

    Make sure to update you .env variables.
    
    If using a local instance of mongo you should update the url.

    DATABASE_URL=mongodb://localhost:27017/

    All other env variables are found in the link below.
    Make sure to remove DATABASE_URL.

    ENV_VARS: https://eunityusa.com/dashboard/env_vars

    If it's your first time accessing the website, you will need to wait for your email to be whitelisted. 

    Any team lead is able to whitelist your email




