# start and configure MiniKube
minikube start
kubectl config use-context minikube
minikube docker-env --shell powershell | Invoke-Expression

# build docker image with DockerFile
docker build -t my-custom-nginx .

# install Prometheus and Grafana via helm
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo update
kubectl create namespace kubernetes-monitoring
helm install prometheus prometheus-community/kube-prometheus-stack --namespace kubernetes-monitoring

# create mysql and custom nginx container 
kubectl apply -f mysql.yaml
kubectl apply -f deployment.yaml

# browse nginx page
minikube service custom-nginx-service

# run the following to browse the Grafana page
# minikube service prometheus-grafana -n kubernetes-monitoring
