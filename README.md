# DockerCICDPipeline
Create poc repo to send a simple spring boot application to dockerhub, containerize it, then use as part of a cicd repo

DOCKER COMMANDS TO USE DOCKER - DOCKERFILE ONLY BUILDING A SINGLE DOCKER IMAGE - NOT CONTAINER

PREREQUASITE
it is always best practice to log into docker as soon as you plan on begin using it 
1. log into docker via cli
docker login
username: <account email address>
password: <account password>
enter you should see the following
Login Succeeded

2. Ensure your Dockerfile is configured correctly 
FROM <base_container>  #check to see if new verison is avaliable - additionally, if we want this hosted on another base container, we cna explore other base containers
ARG JAR_FILE=<./<Jar filepath relative to the Dockerfile file>> #Make sure to include ./ before you paste in your copy relitive path
COPY <target/<your jar file name here.jar>> <name of new jar file>.jar
ENTRYPOINT ["java","-jar","<name of new jar file>.jar"]

Example
FROM openjdk:17-jdk
ARG JAR_FILE=./save_file_to_s3_springboot_app/target/APIData-0.0.1-SNAPSHOT.jar
COPY target/APIData-0.0.1-SNAPSHOT.jar /app.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]


RUNNING THE DOCKER COMMANDS
1. check for docker images if any currently exist
docker images

2. make the build 
docker build -t <name of the new image you give this> <build from where>

#Example
docker build -t testimage .

3. run the docker image 
docker run <name of image> ---> you cna get this by running command 1

Example
docker images
testimage             latest    507e60ecfeca   29 minutes ago   540MB

example
docker run testimage

deleting an image 
docker rmi -f <Name of the image>
or 
docker rm <image id>
exmaple 
docker rmi -f testimage
**Will remove the test image we created

-----------------------------------------------------------------
PUSHING TO DOCKERHUB - from prebuilt image - not tagged properly 

1. We first need to create the image locally remmeber, we do this docker build -t <name of image> <from this directory>

2. List images via docker images

3. Apply a tag to docker 
In the format of 
docker tag <image id> <docker username - not the email- but your username>/<repo name - find in docker hub>:<tag with a custom tag in your repo - you decide this>

example
docker tag 507e60ecfeca thebuckeyeman20/springbootimages:apiapp

4. Push yoiur docker image to DOCKERHUB
docker push <docker username - not the email - but your username>/<image name>:<tag with a custom tag in your repo - you decide this - MUST match what tag you specified in step 3>

exmaple
docker push thebuckeyeman20/springbootimages:tagname
-----------------------------------------------------------------
DOCKER IMAGE NOW PUSHED TO DOCKERHUB
-----------------------------------------------------------------

PUSHING TO DOCKERHUB - FROM NEW IMAGE BUILD

1. We first need to create the image locally
docker build -t <docker username - not the email- but your username>/<repo name - find in docker hub>:<tag with a custom tag in your repo - you decide this> <build from where>

example 
docker build -t thebuckeyeman20/springbootimages:apiapplication .
**This will create an image with the tag of thebuckeyeman20/springbootimages:apiapplication

2. Push to docker hub
docker push <docker username - not the email - but your username>/<image name>:<tag with a custom tag in your repo - you decide this - MUST match what tag you specified in step 1>

exmaple 
docker push thebuckeyeman20/

-----------------------------------------------------------------
DOCKER IMAGE NOW PUSHED TO DOCKERHUB
-----------------------------------------------------------------

PULLING DOCKER IMAGE FROM DOCKER hub
1. log into docker via cli - if you have not already
docker login
username: <account email address>
password: <account password>
enter you should see the following
Login Succeeded

2. Pull the docker image already stored in docker hub

docker pull <docker username - not the email - but your username>/<image name>:<tag - See on dockerhub>

example 
docker pull thebuckeyeman20/springbootimages:apiapp
this will pull the docker image in the springbootapp repo with the tag of apiapp

3. Run the pulled docker container locally via cli
docker run <docker username - not the email - but your username>/<image name>:<tag - See on dockerhub>
**Yopur file is not running locally and pulled form dockerhub



USING DOCKER_COMPOSE TO BUILD CONTAINERS
1. befor we begin we generally already need to have followed the steps above. We need images created, tagged, and uploaded to the docker hub. After we have thease containers uploaded, we can begin with docker-compose.yml

Why Docker-compose.yml? 
Well with docker-compose.yml, we can create containers to host a variety of images and run them locally on our machiene, as well as 
**Possibly - look into - Automatically have the application deploy resources upon build - see capabilities later

2. Beghin by adding the following code to docker-compose.yml
version: '3.8'

services: #We will define the services in our app here
  springbootapp:
    image: thebuckeyeman20/springbootimages:apiapp #Replace with the actual image repo and tag
    container_name: springbootapp #Adding a custom name for our docker container
    ports:
      - 8081:8081 #Specify the ports we want this running on
    environment: #Set environment variables needed by spring boot app
      - SPRING_PROFILES_ACTIVE=dev #Enabling the dev environemnt
#We can add in additional containers to run in the docker-compose area, this is super nice if we want to have somethign running while we work
**Review the comments and adjust as nessasary, this is all pretty self explanitory

3. After you have added all of the different images we want to run in the single container into docker-compoase.yml we can run
docker-compose up
**This will build the container, as well as start the server





SETTING UP THE CICD PIPELINE

Prerequasites:
1. Create the docker-compose.yml file 
version: '3.8'

services:
  container1:
    image: thebuckeyeman20/cicd:image1
    container_name: container1
    ports:
      - 8082:8082
    environment:
      - SPRING_PROFILES_ACTIVE=dev

#We need to add in all repos we want to make a build off every commit(Every time we make a commit, build what) this usually will refer to the current workspace so if we make a commit on this repo, build an image of this repo in dockerhub




CI
In order to set up the CI pipeline in dockerhub we first need to configure a few things. 
1. In github, navigate to your repo -> settings -> Serets and variables -> Action -> New Repositorty Secret
Add in the following Secrets
DOCKER_PASSWORD
DOCKER_USERNAME

2. After you have your gitgub repo secrets set up, it is time to make the pipeline
Create a new directory in the root of your project 
.github
|-workflows
   |-ci.yml

3. Add in the following code for the CI pipeline 
name: CI/CD Pipeline

on:
  push:
    branches: #Add additional branches if we neeed to add additional branches
      - main 
      - dev
      - test
      - feature/dockerimagecreation
      - feature/cd

jobs:
  build:
    runs-on: ubuntu-latest 

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2

      - name: Log in to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Build Docker image
        run: |
          docker build -t thebuckeyeman20/cicd:image1 .

      - name: Push Docker images
        run: |
          docker push thebuckeyeman20/cicd:image1


If you want to add additional configuration to kick off builds of additional images specify them in the  - name: Build Docker image and     - name: Push Docker images sections

TROUBLESHOOTING CI:
ensure the branch you are commiting code to is listed in the list of branches at the top of ci.yml

Check your github repo actions tab for logs on the run and build to see if anything failed and get error details.