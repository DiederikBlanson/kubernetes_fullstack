# Front-end Engineer
kubectl delete rolebinding frontends -n development
kubectl delete clusterrole frontend-role

# Backend engineer
kubectl delete rolebinding backends -n development
kubectl delete clusterrole backend-role

# Junior Full-stack developer
kubectl delete rolebinding junior-fs-devs -n development
kubectl delete role junior-fs-dev-role -n development

# Data Analyst
kubectl delete rolebinding data-analysts -n production
kubectl delete role data-analyst-role -n production

# DevOps Engineer
kubectl delete rolebinding devops -n production
kubectl delete role devops-role -n production