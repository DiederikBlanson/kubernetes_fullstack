# Fullstack application in Kubernetes

This repository aims to demonstrate how to deploy a full-stack application, including the frontend, backend, and database, on a local Kubernetes cluster. The process of setting up the environment can be complex, so the documentation is regularly updated to make it easier to follow. However, it is important to note that using this code in a production setting is done at your own risk, and you should thoroughly evaluate each component of the system before using it. If you have any questions or suggestions for improving the current setup, please don't hesitate to contact me.
<br/>

## Components
"kube-full," also known as the "system," refers to a fullstack application that includes a frontend, backend, and database. It is deployed on a local Kubernetes cluster, which consists of one or more nodes. The container images for kube-full are stored in DockerHub, a cloud repository. When certain push/pull requests are made on GitHub, certain actions are triggered. Currently, if there are any changes to the frontend or backend application, a new Docker image will be created and added to the registry.

<br/>

## High-level 'kube-full' architecture
The fullstack application uses the following technologies:
1. Front-end: A React application written in TypeScript, using the default template of create-react-app which displays a single page. This allows the connection with the server to be tested, and verifies that the server returns a response.
2. Back-end: A NodeJS application written in TypeScript, using Express. This API consists of a single endpoint which returns a dummy response to the frontend.
3. Database: A PostgreSQL database with a single table. Although there is a Docker container for the database, it is not yet connected to the backend (TODO).

<br/>

## Prerequisites 
It is important to have a comprehensive understanding of the full system in order to effectively use and modify the different components. The following are the initial steps to get started:
1. Familiarize yourself with the various components of the system and how they are interconnected.
2. Determine which specific parts of the repository you will be using.
3. Follow the setup instructions to get the complete system up and running. This may involve installing dependencies, connecting to a database, and configuring any necessary settings.

### Install Kubernetes/Docker
To set up the system on Ubuntu 20.04 LTS, follow these steps:
1. Install Ubuntu on your local virtual machine or production servers.
2. (Optional) Enable SSH to allow for easy access to the server. Refer to the file scripts/enable-ssh.sh for instructions.
3. Install Kubernetes and Docker by following the steps outlined in the file scripts/kubernetes-docker-install.sh.
4. Create credentials to connect to DockerHub. (TODO)

### Create a DockerHub-account
In order to push the container images to the cloud repository on DockerHub, you will need to create a DockerHub account (https://hub.docker.com/signup). After creating your account, be sure to update the values in the ```docker-compose``` and ```values.yaml``` files to reflect your DockerHub username. Currently, the values are set to "dedder98," which is the username for my personal DockerHub account.

### Add DockerHub secrets to GitHub Actions
These credentials are necessary to push changes in the images to DockerHub with help of the GitHub Actions.

<br/>

## How to get started?
Great! Now that the environment is set up, the application is ready to be run. Here is a list of available documentation (some of which may still be a work in progress):
- ```docs/local-setup.sh```: run the application locally with Docker-Compose. Here, no Kubernetes is involved.
- ```docs/kubernetes-setup.sh```: run the application in a Kubernetes cluster
- ```docs/multiple-nodes.sh```: when the Kubernetes cluster is succesfully created, new nodes can be added.
- ```docs/frontend.sh```: explains how the frontend works
- ```docs/backend.sh```: explains how the backend works
- ```docs/database.sh```: explains how the database works

If you have any questions or encounter any issues while running the application, feel free to refer to these resources or reach out for additional support.