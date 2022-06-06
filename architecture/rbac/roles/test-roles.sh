# check if diederik and eva are junior fullstack developers, only permission all resources in development namespace
kubectl auth can-i get pods -n development --as diederik
-> yes
kubectl auth can-i get pods -n staging --as diederik
-> false
kubectl auth can-i get pods -n development --as eva
-> yes


# check if vishwa is a frontend engineer, permission to only frontend resources within all namespaces
kubectl auth can-i get services/frontend -n development --as vishwa
-> yes
kubectl auth can-i get services/frontend -n staging --as vishwa
-> yes
kubectl auth can-i get services/api -n development --as vishwa
-> no

kubectl auth can-i get deployments/frontend -n development --as vishwa
-> yes
kubectl auth can-i get deployments/api -n development --as vishwa
-> no

kubectl auth can-i get pods/frontend -n development --as vishwa
-> yes
kubectl auth can-i get pods/api -n development --as vishwa
-> no


# check if john is a backend engineer, permission to only backend resources within all namespaces
kubectl auth can-i get services/api -n development --as john
-> yes
kubectl auth can-i get services/frontend -n development --as john
-> no

kubectl auth can-i get deployments/api -n development --as john
-> yes
kubectl auth can-i get deployments/frontend -n development --as john
-> no

kubectl auth can-i get pods/api -n development --as john
-> yes
kubectl auth can-i get pods/frontend -n development --as john
-> no


# check if nuo is a data analyst, permission to only backend pod on production namespace
kubectl auth can-i get pod/postgres -n production --as nuo
-> yes
kubectl auth can-i get pod/frontend -n production --as nuo
-> no
kubectl auth can-i get pod/postgres -n development --as nuo
-> no
kubectl auth can-i get pod/frontend -n development --as nuo
-> no

# check if lara is a devops engineer, permission to all resources except pods on development, staging and production namespace
kubectl auth can-i get services/postgres -n production --as lara
-> yes
kubectl auth can-i get services/api -n production --as lara
-> yes
kubectl auth can-i get pods/postgres -n production --as lara
-> no

kubectl auth can-i get services/postgres -n development --as lara
-> yes
kubectl auth can-i get services/frontend -n development --as lara
-> yes
kubectl auth can-i get pods/postgres -n development --as lara
-> no