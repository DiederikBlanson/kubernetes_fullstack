# Creating a NodeJS (Express) application with TypeScript
This guide will walk you through the process of creating a NodeJS-application with TypeScript, building a Docker container for the app, and (optionally) creating a Helm chart. The steps involved are as follows:

1. Create a NodeJS app using TypeScript
2. Dockerize the app
3. (Optional) Create a Helm chart

## Create NodeJS app
The steps are included here: https://levelup.gitconnected.com/creating-a-node-js-api-with-express-and-typescript-549fba5f5a33


## Dockerize NodeJS App
1. The `.dockerignore` file has the contents `/node_modules`. As such, `node_modules` will be ignored during the dockerization process.
2. The `Dockerfile` file consists of the image. As you can see in the `/system/backend/app` folder, there are two Dockerfiles for both the development and production environments.

## Create Helm Chart
Normally, you don't want to create an individual Helm chart as `system/helm-run.sh` should spin up the whole environment. However, it is still possible to do so by performing the following steps:
1. Install a new chart 
```bash
microk8s helm3 install [name-chart] ./helm-backend
```
2. Uninstall the chart
```bash
microk8s helm3 uninstall [name-chart]
```