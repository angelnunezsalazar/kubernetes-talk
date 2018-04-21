# Crear DNS (requisito para K8S Federation)
gcloud dns managed-zones create federation --description=federation --dns-name=federation.angelnunez.com.
export DNS_ZONE=federation.angelnunez.com.

# Get credentials for all clusters
gcloud container clusters get-credentials us-east-cluster --zone us-east1-b --project angel-nunez
kubectl create clusterrolebinding snahider-admin --clusterrole=cluster-admin --user=snahider@gmail.com
gcloud container clusters get-credentials southamerica-east-cluster --zone southamerica-east1-a --project angel-nunez
kubectl create clusterrolebinding snahider-admin --clusterrole=cluster-admin --user=snahider@gmail.com
gcloud container clusters get-credentials europe-west-cluster --zone europe-west1-b --project angel-nunez
kubectl create clusterrolebinding snahider-admin --clusterrole=cluster-admin --user=snahider@gmail.com

#Aliases
kubectl config set-context us-east --cluster=gke_angel-nunez_us-east1-b_us-east-cluster --user=gke_angel-nunez_us-east1-b_us-east-cluster
kubectl config set-context eu-west --cluster=gke_angel-nunez_europe-west1-b_europe-west-cluster --user=gke_angel-nunez_europe-west1-b_europe-west-cluster
kubectl config set-context southamerica-east --cluster=gke_angel-nunez_southamerica-east1-a_southamerica-east-cluster --user=gke_angel-nunez_southamerica-east1-a_southamerica-east-cluster

# Federation Control Plane
kubefed init fed --host-cluster-context=us-east --dns-provider="google-clouddns" --dns-zone-name=${DNS_ZONE}
kubectl config get-contexts # Creará un nuevo contexto llamado Fed

# Registrar los clusters
kubectl config use-context fed #federation api 35.185.85.221
kubefed join us-east --host-cluster-context=us-east --cluster-context=us-east
kubefed join eu-west --host-cluster-context=us-east --cluster-context=eu-west
kubefed join southamerica-east --host-cluster-context=us-east --cluster-context=southamerica-east
kubectl get clusters #Probar que se hayan registrado

kubectl --context=kfed create ns default