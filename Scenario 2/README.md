Start the Docker Desktop
---
Execute the runme.ps1 in powershell.

The incremental counter page will load after the script completes.

---

use the following command to access the nginx pod to test connection to mysql

kubectl exec -it <pod name> /bin/bash
mysql -h mysql -u root -p

use the following to view the content of mysql

show databases;
show tables;
use mydata;
select * from friends;


---

run the following command to access the Grafana page

minikube service prometheus-grafana -n kubernetes-monitoring
