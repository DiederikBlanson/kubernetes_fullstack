# Kubernetes Setup


## Add private registry to kubernetes
sources:
- https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/

In order to give kubernetes access to a private Docker registry, we have to generate a secret.
1. Generate a secret on the command line: ```kubectl create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>```
2. Generate a ```secret.yml``` file in the helm folder and put the contents of ```kubectl get secret regcred --output=yaml``` in there.
3. Delete the secret from the Kubernetes environment as you only want the definition in the file.
4. Change the following defintion in values.yml, and replace the image with the new your-private-image:
```
# deployment
...
container:
  image: <your-private-image>
...
```