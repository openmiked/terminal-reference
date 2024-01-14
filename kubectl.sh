ps -aux | grep kubelet  # identify Kubelet config path/file

watch -n 5 'kubectl get nodes | sort -k4 | awk '"'"'$2 == "Ready"'"'"' | nl -v0; echo; kubectl config current-context'

kubectl version
kubectl config view
kubectl config use-context <cluster-name>

kubectl get events
kubectl get events -A --field-selector involvedObject.name={name} -o json | jq
kubectl get events -A --field-selector involvedObject.kind={kind} -o json | jq
kubectl get pods --all-namespaces
kubectl get nodes --show-labels
kubectl get deployments
kubectl get services
kubectl get secret name -o jsonpath="{.data['field']}" | base64 -d

kubectl top pod
kubectl top node

kubectl run <pod-name> --image=<image-name/path> [--image-pull-policy=Never (if its local)]
kubectl run redis --image=redis --restart=Never --dry-run=client -o yaml > redis.yaml
kubectl create deployment --image=nginx nginx --dry-run=client -o yaml
kubectl expose pod redis --port=6379 --name redis-service --dry-run=client -o yaml
kubectl create service clusterip redis --tcp=6379:6379 --dry-run=client -o yaml
kubectl expose deployment <deployment-name> --type=[NodePort, LoadBalancer, etc.] --port=[80]

kubectl taint nodes <node-name> <key>=<value>:<[taint-effect|-]>
kubectl patch ServiceInstance <service-instance-name> -p '{"metadata":{"finalizers":null}}' --type=merge
# Taint Effects:  NoSchedule | PreferNoSchedule | NoExecute

kubectl argo rollouts dashboard
kubectl argo rollouts promote <rollout-name>

### MAINTENANCE
kubectl drain <node-name> [--ignore-daemonsets]
kubectl cordon <node-name>
kubectl uncordon <node-name>
kubeadm upgrade node
apt install kubeadm=1.26.0-00 kubelet=1.26.0-00

## Take backups
export ETCDCTL_API=3   # Without this env var you will see the error: No help topic for 'snapshot'
kubectl get all --all-namespaces -o yaml > app-deploy-services.yaml
etcdctl \
    snapshot save /opt/cluster1.db \
    --endpoints=https://127.0.0.1:2379 \
    --cacert=/etc/kubernetes/pki/etcd/ca.crt \
    --cert=/etc/kubernetes/pki/etcd/server.crt \
    --key=/etc/kubernetes/pki/etcd/server.key

## Restore
service kube-apiserver stop service

ps -ef | grep etcd
etcdctl \
    snapshot restore /opt/cluster2.db \
    --data-dir /var/lib/etcd-data-new \
    --endpoints=https://127.0.0.1:2379 \
    --cacert=/etc/etcd/pki/ca.pem \
    --cert=/etc/etcd/pki/etcd.pem \
    --key=/etc/etcd/pki/etcd-key.pem # Update --data-dir for etcd as well

chown -R etcd:etcd /var/lib/etcd-data-new
vim /etc/systemd/system/etcd.service # To update data directory if needed

systemctl daemon-reload
service etcd restart
service kube-apiserver start

scp <node-name>:<source-backup-file-name> <destination-backup-file-name>

## Authorization

kubectl auth can-i <command-to-check> [--as <user-name>]

###
kubectl create|describe|get serviceaccount <account-name>
kubectl create token <service-account-name>


### Certificates
cat john-doe.csr | base64 | tr -d "/n"
kubectl get csr
kubectl get csr <csr-name> -o yaml # View details for actual certificate
kubectl certificate approve <csr-name>
echo <base-64-encoded-certificate> | base64 --decode

kubectl label nodes <node-name> <label-key>=<label-value>







<service-name>.<namespace-name>.svc.cluster.local

<node-name> service <service-name>
<node-name> addons [enable/disable] <addon-name>  ------> ex: minikube addons enable dashboard

kubectl delete service <service-name>
kubectl delete deployment <deployment-name>

kubectl apply -f <filename>

kubectl apply -f dashboard-adminuser.yaml
kubectl create -f dashboard-admin-clusterrolebinding.yaml

kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')

===================================================================================

minikube start
minikube dashboard
minikube stop
minikube delete

===================================================================================

helm create <chart-name>
helm lint <path>
helm template <release-name> <path> --debug
helm install <release-name> <path> --dry-run
