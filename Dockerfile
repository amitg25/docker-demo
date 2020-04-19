FROM openjdk:8u191-jre-alpine3.8

RUN apk add curl jq

# Workspace
WORKDIR /usr/share/docker-demo

# ADD .jar under target from host
# into this image
ADD target/vmware-selenium-docker.jar 			vmware-selenium-docker.jar
ADD target/vmware-selenium-docker-tests.jar 	vmware-selenium-docker-tests.jar
ADD target/libs							        libs

# in case of any other dependency like .csv / .json / .xls
# please ADD that as well

# ADD suite files
ADD book-flight-module.xml				book-flight-module.xml
ADD search-module.xml					search-module.xml

# ADD health check script
ADD healthcheck.sh                      healthcheck.sh

# BROWSER
# HUB_HOST
# MODULE
#ENTRYPOINT java -cp vmware-selenium-docker.jar:vmware-selenium-docker-tests.jar:libs/* -DBROWSER=$BROWSER -DHUB_HOST=$HUB_HOST org.testng.TestNG $MODULE
ENTRYPOINT sh healthcheck.sh 