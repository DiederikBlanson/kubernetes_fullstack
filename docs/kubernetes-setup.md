# Kubernetes Setup

Assuming you have correctly configured your environment by installing Kubernetes and creating a Docker account, you are nearly ready to proceed. One crucial aspect that should not be overlooked is the addition of a private registry to your Kubernetes cluster. This step is vital as you will likely be pulling Docker containers from a private registry, and thus, you must authenticate yourself. Please refer to the "Add private registry to Kubernetes" section for instructions on how to complete this process.

## Add private registry to Kubernetes
In order to give kubernetes access to a private Docker registry, we have to generate a secret.
1. Generate a secret on the command line: ```kubectl create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>```
2. Generate a ```secret.yml``` file in every helm folder (which includes the frontend, backend and db) and put the contents of ```kubectl get secret regcred --output=yaml``` in there.
3. Delete the secret from the Kubernetes environment as you only want the definition in the file using ```kubectl delete secret regcred```.
4. Change the following defintion in `values.yml` in every helm folder, and replace the image with the new `your-private-image`:
```
# deployment
...
container:
  image: <your-private-image>
...
```

## Finally, let's run Kubernetes!
Now that you have added the necessary secrets, you can launch the application by executing the following command:
```bash
sh system/helm-run.sh
```

This command will spin up all pods, deployments, and services required for your application. If you ever need to delete all the resources, use the following command:
```bash
sh system/helm-delete.sh
```
---
sources:
- https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
- https://github.com/mhart/alpine-node/issues/28
- https://luppeng.wordpress.com/2020/02/28/install-and-start-postgresql-on-alpine-linux/