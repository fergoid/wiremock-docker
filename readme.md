# Using the Wiremock Docker Image

The image runs wiremock standalone and takes three arguments
1. clone_url = the clone url of the repo that holds your mappings and __files directories
2. repo_name = the name of your repo
3. runtime_options = runtime options for Wiremock.  Useful if you want to proxy the real API as well as serving cached responses.  

There is no point recording using this image!!

Don't change the port as the image exposes 8080

[Wiremock Standalone](http://wiremock.org/docs/running-standalone/)

To build the image
```
docker build --tag my-cool-tag --build-arg clone_url=https://github.com/me/mycoolrepo.git --build-arg repo_name=mycoolrepo .
```

This will create the image with the cached files in it which will be used by Wiremock.

To run it
```
docker run -d -p 8084:8080  wiremock-new
```

## Creating an image
Record your API interactions locally and then create a git repo and commit the mappings and __files directories and their contents.

Create a readme file that details the services you are virtualising.  

It's probably best to create the image with a descriptive tag of the service / API you are virtualising.

# Readme - Example

This server virtualises the following APIs

**Country API**   
http://services.groupkt.com/
    **country/get/iso2code/**  
    Countries; DE, FR, GB, IN, JP, PK, US, ZZ  

**Open Weather API - Cities**   http://api.openweathermap.org/
    **/data/2.5/weather?q=**  
    Parameters; London

The image does not proxy the oriignal service so any calls outside of these will fail.