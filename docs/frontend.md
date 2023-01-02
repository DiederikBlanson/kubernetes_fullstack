# React and Kubernetes
This code repository aims to provide an insight on how one can create a React application (TypeScript), and
deploy this code on a kubernetes cluster. The steps are the following:
1. Create a React-app
2. Create a Docker container
3. Publish to Kubernetes

# Create a React-app
sources:
- https://create-react-app.dev/docs/adding-typescript/

1. ```create-react-app``` is used to create the React app. Using the command ```npx create-react-app my-app --template typescript``` simply creates an app with TypeScript.
2. Delete ```package-lock.json``` and ```node_modules``` and enter the command ```yarn install```. Now yarn is used as the package manager, which additionally creates a ```yarn.lock``` file.
3. Create a ```config.js``` file in the ```public``` folder as this file is going to be used for environment variables. Instead of using ```process.env[key]```, we will be using ```window[key]``` as otherwise env variables cannot be correctly injected into the Kubernetes environment.
4. Add ```<script src="%PUBLIC_URL%/config.js"></script>``` to the file ```public/index.html```.
5. Create a file ```src/types/index.d.ts``` in order to add all the types of the window variables. An example is shown below:
```
export {};
declare global {
    interface Window {
        REACT_APP_BACKEND_URL: string; 
    }
}
```


# Dockerize React app
sources:
- https://www.knowledgehut.com/blog/web-development/how-to-dockerize-react-app

1. Create a ```.dockerignore``` file with the contents ```/node_modules```.
2. Create a ```docker-compose.yml``` file with the contents 
```
FROM node:19-alpine as builder
WORKDIR /app
COPY package.json . 
COPY yarn.lock .
RUN yarn install 
COPY . . 
RUN yarn build

# stage 2
FROM nginx:1.19.0
WORKDIR /usr/share/nginx/html 
RUN rm -rf ./* 
COPY --from=builder /app/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]
```
3. Create a ```docker-compose.yml``` file with the following contents. User and image-name should be changed to desired values.
```
version: "3.8"
services:
  app:
    container_name: react-container
    image: [username]/[image-name]
    build:
      context: .
    ports:
      - 80:80
```
4. Build the container: ```docker-compose build```
6. Push live to docker registry: ```docker push [username]/[image-name]```. Be sure to login

# Add private registry to kubernetes
sources:
- https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/

In order to give kubernetes access to a private Docker registry, we have to generate a secret.
1. Generate a secret on the command line: ```kubectl create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>```
2. Generate a ```secret.yml``` file in the helm folder and put the contents of ```kubectl get secret regcred --output=yaml``` in there.
3. Delete the secret from the Kubernetes environment as you only want the definition in the file.
4. Add the following defintion in values.yml:
```
# deployment
...
container:
  image: <your-private-image>
...
```

# Create Kubernetes Helm chart
Normally, you don't want to create an individual helm chart as ```system/helm-run.sh``` should spin up the whole environment. However, it is still possible by performing the following steps:
1. Install a new chart: ```microk8s helm3 install [name-chart] ./helm-chart```
2. Uninstall: ```microk8s helm3 uninstall [name-chart]```

# Create new version kubernetes
1. If deployment is already created, you can make a new rollout: ```kubectl rollout restart deployment/[deployment]```