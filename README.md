`an app that uses client go to talk to kube api server to do things


because kubernetes is container orchestrator, we have to containerize our app

lets have a look into the yaml

`k create deployment lister --image gmeyer1/lister:0.1.0 --dry-run=client -oyaml > mani
fests > lister.yaml`

kubeconfig doesnt exist in cluster
there is a method that can get configuration while running inside cluster

InClusterConfig

We know that pods gets mounted default service role to provide identity to authenticate to api server. we can use this service account to talk to server. InClusterConfig will look at the path where service account gets mounted

... reads the details from the path where kubelete mounts the default service account

uses tokenFile to authenticate against k8s cluster


gotta create RBAC  since default service account not allowed to list pods and deployments

`k create role poddepl --resource pods,deployments --verb list`

`k create rolebinding poddepl --role poddepl --serviceaccount default:default`

summary

use rest.InClusterConfig to configure app so it can run inside kubercluster as a pod

# deploy-clientgo
