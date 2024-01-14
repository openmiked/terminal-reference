# Add a Git repository via SSH using a private key for authentication, ignoring the server's host key:
argocd repo add git@git.example.com:repos/repo --insecure-ignore-host-key --ssh-private-key-path ~/id_rsa
# Add a Git repository via SSH on a non-default port - need to use ssh:// style URLs here
argocd repo add ssh://git@git.example.com:2222/repos/repo --ssh-private-key-path ~/id_rsa
# Add a private Git repository via HTTPS using username/password and TLS client certificates:
argocd repo add https://git.example.com/repos/repo --username git --password secret --tls-client-cert-path ~/mycert.crt --tls-client-cert-key-path ~/mycert.key
# Add a private Git repository via HTTPS using username/password without verifying the server's TLS certificate
argocd repo add https://git.example.com/repos/repo --username git --password secret --insecure-skip-server-verification
# Add a public Helm repository named 'stable' via HTTPS
argocd repo add https://charts.helm.sh/stable --type helm --name stable  
# Add a private Helm repository named 'stable' via HTTPS
argocd repo add https://charts.helm.sh/stable --type helm --name stable --username test --password test
# Add a private Helm OCI-based repository named 'stable' via HTTPS
argocd repo add helm-oci-registry.cn-zhangjiakou.cr.aliyuncs.com --type helm --name stable --enable-oci --username test --password test
# Add a private Git repository on GitHub.com via GitHub App
argocd repo add https://git.example.com/repos/repo --github-app-id 1 --github-app-installation-id 2 --github-app-private-key-path test.private-key.pem
# Add a private Git repository on GitHub Enterprise via GitHub App
argocd repo add https://ghe.example.com/repos/repo --github-app-id 1 --github-app-installation-id 2 --github-app-private-key-path test.private-key.pem --github-app-enterprise-base-url https://ghe.example.com/api/v3
# Add a private Git repository on Google Cloud Sources via GCP service account credentials
argocd repo add https://source.developers.google.com/p/my-google-cloud-project/r/my-repo --gcp-service-account-key-path service-account-key.json

# Create a directory app
argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-namespace default --dest-server https://kubernetes.default.svc --directory-recurse
# Create a Jsonnet app
argocd app create jsonnet-guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path jsonnet-guestbook --dest-namespace default --dest-server https://kubernetes.default.svc --jsonnet-ext-str replicas=2
# Create a Helm app
argocd app create helm-guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path helm-guestbook --dest-namespace default --dest-server https://kubernetes.default.svc --helm-set replicaCount=2
# Create a Helm app from a Helm repo
argocd app create nginx-ingress --repo https://kubernetes-charts.storage.googleapis.com --helm-chart nginx-ingress --revision 1.24.3 --dest-namespace default --dest-server https://kubernetes.default.svc
# Create a Kustomize app
argocd app create kustomize-guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path kustomize-guestbook --dest-namespace default --dest-server https://kubernetes.default.svc --kustomize-image gcr.io/heptio-images/ks-guestbook-demo:0.1
# Create a app using a custom tool:
argocd app create ksane --repo https://github.com/argoproj/argocd-example-apps.git --path plugins/kasane --dest-namespace default --dest-server https://kubernetes.default.svc --config-management-plugin kasane

# Login and update the initial admin password
argocd admin initial-password -n argocd
argocd login <ARGOCD_SERVER>
argocd account update-password  

##  Add Donohue Engineering repos
argocd repo add git@gitlab.com:openmiked/dev/apps/core-app.git \
    --name donohue-engineering--core-app \
    --ssh-private-key-path ~/Engineering/security/donohue.engineering/gitlab/argocd_ed25519
argocd repo add git@gitlab.com:openmiked/ops/infra/cloud-resources.git \
    --name donohue-engineering--infra-resources \
    --ssh-private-key-path ~/Engineering/security/donohue.engineering/gitlab/argocd_ed25519

##  Add Helm Chart repos
argocd repo add https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts \
    --name secrets-store-csi-driver \
    --project csi-drivers \
    --type helm
argocd repo add https://aws.github.io/secrets-store-csi-driver-provider-aws/ \
    --name aws-secrets-manager \
    --type helm

##  Add Donohue Engineering apps
argocd app create argo-cd \
    --repo git@gitlab.com:openmiked/ops/infra/cloud-resources.git \
    --path accounts/sandbox/3__applications/kubernetes/argo-cd/ \
    --revision argo-tcgplayer-demo \
    --dest-namespace argocd \
    --dest-server https://kubernetes.default.svc \
    --core
argocd app create core-app \
    --repo git@gitlab.com:openmiked/ops/infra/cloud-resources.git \
    --path accounts/sandbox/3__applications/kubernetes/core-api/ \
    --revision argo-tcgplayer-demo \
    --dest-namespace default \
    --dest-server https://kubernetes.default.svc \
    --core
argocd app create keycloak \
    --repo git@gitlab.com:openmiked/ops/infra/cloud-resources.git \
    --path accounts/sandbox/3__applications/kubernetes/keycloak/ \
    --revision argo-tcgplayer-demo \
    --dest-namespace default \
    --dest-server https://kubernetes.default.svc \
    --core
argocd app create shared-alb-ingresses \
    --repo git@gitlab.com:openmiked/ops/infra/cloud-resources.git \
    --path accounts/sandbox/3__applications/kubernetes/shared-ingresses/ \
    --revision argo-tcgplayer-demo \
    --dest-namespace default \
    --dest-server https://kubernetes.default.svc \
    --core

##  Add Helm Chart apps
argocd app create csi-secrets-store \
    --repo https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts \
    --helm-chart secrets-store-csi-driver \
    --revision v1.3.1 \
    --dest-namespace kube-system \
    --dest-server https://kubernetes.default.svc \
    --core
argocd app create secrets-provider-aws \
    --repo https://aws.github.io/secrets-store-csi-driver-provider-aws \
    --helm-chart secrets-store-csi-driver-provider-aws \
    --revision 0.3.2 \
    --dest-namespace kube-system \
    --dest-server https://kubernetes.default.svc \
    --core

