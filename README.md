# Fullstack application in Kubernetes

The aim of this repository is to show a practical example of how a fullstack application (frontend, backend and database) can be deployed on a local Kubernetes cluster. Setting up the whole environment can be quite tedious, hence the documentation is continuously improved. Note: using this code (in production) is on your own risk, and you should be very critical on each component in the system. Do not hesitate to contact me if you have questions, or recommendations on how to improve the current setup.

<br/>

## Components
1. 'kube-full' a.k.a. the 'system': this name refers to the fullstack application consisting of the frontend, backend and database.
2. Kubernetes: kube-full is deployed on a local Kubernetes cluster which consists of one or more nodes.
3. Docker: the images of the containers of kube-full are stored in the Docker hub which is a cloud repository.
4. Github Actions: on specific push/pull Github requests, certain actions are executed. For now, if there is a change in the frontend or backend application, a new Docker image will be created and pushed to the registry. 

<br/>

## High-level 'kube-full' architecture
The technologies used in the fullstack application:
1. Front-end: A React-application written in TypeScript. The default template of ```create-react-app``` is used which displays a single page. Here, we can check the connection with the server and if it returns a response.
2. Back-end: A NodeJS-application written in TypeScript, using Express. This API consists of a single endpoint to return a dummy response to the frontend.
3. Database: A PostgreSQL database with a single table. Although the Docker-container already exists, there is not yet a connection with the backend (TODO).

<br/>

## Prerequisites 
Understanding the full picture might take some time, hence it is important to see what components exist and how they are interconnected. Although you might end up only using specific parts of the repository, I would like to still give the opportunity to set it up completeley. These are the first steps of getting started:

### Install Kubernetes/Docker
The installation guide is suitable for Ubuntu 20.04 LTS. I am testing the system locally in a Virtual Machine but run the production code on 3 physical Ubuntu servers. These are the steps to follow:
1. Install Ubuntu
2. Optionally: enable SSH in order to easily access the server (see the file ```scripts/enable-ssh.sh```).
3. Install Kubernetes/Docker. The exact steps are written down in the file ```scripts/kubernetes-docker-install.sh```.
4. Create credentials to connect with Docker Hub: (TODO)

### Create a Docker Hub account
A Docker Hub account is necessary to push the images to the cloud repository (https://hub.docker.com/signup). Be sure to update the values 'dedder98' in the repository as this is my personal Docker Hub account (which can be found in the ```docker-compose``` and ```values.yaml``` files). 

<br/>

### Commands dev
```docker-compose -f docker-compose-dev.yml build```

### Commands prod
```docker-compose -f docker-compose-prod.yml build```