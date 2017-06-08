# wiremock Dockerfile
# Based on
# https://github.com/carlosroman/docker-wiremock
#

# Pull base image.
FROM openjdk:8-alpine

ARG clone_url
ARG repo_name
ARG runtime_options

ENV RUNTIME_OPTIONS=$runtime_options
ENV CLONE_URL=$clone_url
ENV REPO_NAME=$repo_name

ENV WM_PKG_NAME wiremock-standalone
ENV WM_VERSION 2.6.0

RUN apk --no-cache --virtual .build-dependencies add wget \
    && apk --no-cache --upgrade add ca-certificates \
    && update-ca-certificates --fresh \
    && cd / \
    && wget https://repo1.maven.org/maven2/com/github/tomakehurst/$WM_PKG_NAME/$WM_VERSION/$WM_PKG_NAME-$WM_VERSION.jar \
    && mkdir -p /opt/wiremock/ \
    && apk del .build-dependencies \
    && apk update \
    && apk upgrade \
    && apk add git tree \                                                                                                                                                                                                      
    && mv $WM_PKG_NAME-$WM_VERSION.jar /opt/wiremock/wiremock.jar \
    && mkdir /wiremock \
    && cd /wiremock \
    && git clone $CLONE_URL \
    && mkdir /wiremock/mappings \
    && mkdir /wiremock/__files \
&& cp --verbose -a /wiremock/$REPO_NAME/mappings/* /wiremock/mappings/ \
&& cp --verbose -a /wiremock/$REPO_NAME/__files/* /wiremock/__files/ \
&& rm -r /wiremock/$REPO_NAME \
&& pwd \
&& tree .


WORKDIR /wiremock

# Define mountable directories.
VOLUME ["/wiremock/__files", "/wiremock/mappings"]

# Define default command.
ENTRYPOINT exec java -jar /opt/wiremock/wiremock.jar $RUNTIME_OPTIONS
#ENTRYPOINT pwd && tree .

# Expose ports.
#   - 8080: HTTP
EXPOSE 8080
