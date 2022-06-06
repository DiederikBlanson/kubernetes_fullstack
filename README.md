# About the application
An app for customers to be able to provide review about the products listed.

This assignment is part of the Vrije Universiteit Amsterdam course 'Software Containerization'. Important to note that this repository is forked from https://github.com/Vishwamitra/ireview.

---------
## Structure
The entire application is divided in to 3 services 
- Frontend (React)
- REST API (Python Flask) 
- Database (Postgres)

---------
## Source code
for each services resides in `services` folder. Each services has got its own docker file inside which can be used to generate a `docker image`.
To build an image and spin up you can  use the following command:

```docker build -t ireview-frontend:1.0.0 -f ./services/frontend/Dockerfile .```

```docker build -t ireview-api:1.0.0 -f ./services/api/Dockerfile .```

```docker build -t ireview-db:1.0.0 -f ./services/db/Dockerfile .```

### Docker-Compose
There is a `docker-compose` file created in order to spin up the entire application locally to test it before deploying it in to kubernetes. `docker-compose.yml`

Run the following command to spin up the application locally via docker-compose:

``` docker-compose up -f docker-compose.yaml ```

### Kubernetes Services, Deployments, ConfigMap, Secreted, Storage, Networkpolicy etc. [all other artifacts]

Before creating helm charts, we have created these kubernetes artifacts separately for each services in following folders:
`./architecture/frontend/old/` `./architecture/api/old/` `./architecture/db/old/`

In order to install via above artifacts, you need to run one by one all the files like following example:

``` kubectly apply -f deployments.yaml ``` 

### Helm Charts

In order to deploy the services in Kubernetes with one single commands, we have created helm charts for each services. They can be found in following folders
`./architecture/frontend/helm/` `./architecture/api/helm/`  `./architecture/db/helm/`

---------
## Installation using helm Chart (single command)
This is the single command required in order to install the entire application.
``` > sh install.sh ``` 

Above script calls following helm charts in order to deploy them in kubernetes inside a namespace called ireview-app

#### Create namespace
Use following command to create a new namespace before running the following commands:

``` kubectl create namespace ireview-app ``` 

``` helm install postgres ./architecture/db/helm/postgres/ -n ireview-app``` 

``` helm install api ./architecture/api/helm/api -n ireview-app``` 

``` helm install frontend ./architecture/frontend/helm/frontend -n ireview-app```

---------
## Uninstallation using Helm chart (using single command)
This is the single command required in order to install the entire application.
``` > sh uninstall.sh ``` 

Above script calls following helm charts in order to deploy them in kubernetes inside a namespace called ireview-app


``` helm uninstall frontend -n ireview-app ``` 

``` helm uninstall api -n ireview-app ``` 

``` helm uninstall postgres -n ireview-app ``` 

---------
## Upgrade
For a new version of the software following command is used to upgrade the services: 

``` $ kubectl upgrade frontend frontend/ -n ireview-app``` 

```  $ kubectl upgrade api api/ -n ireview-app``` 

``` $ kubectl upgrade db db/ -n ireview-app ``` 

---------
## Scale up/Scale down

In order to scaleup each of our services, you can use the following command to increase the number of replicas:

``` $ kubectl scale --replicas 2 deployment/frontend -n ireview-app``` 

``` $ kubectl scale --replicas 3 deployment/api -n ireview-app ``` 

``` $ kubectl scale --replicas 2 deployment/postgres -n ireview-app ``` 
