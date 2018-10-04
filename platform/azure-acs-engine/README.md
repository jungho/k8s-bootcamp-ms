# ACS Engine #

ACS Engine is an Open Source project that is the basis for Kubernetes on Azure.  Azure services such as ACS and AKS (managed Kubernetes) depends on the code upstream in the ACS Engine project.

While Azure K8S services such as AKS provide many benefits, such as automating provisioning of the cluster, making upgrading the cluster, adding new nodes, snapshoting etcd, etc very easy, you get what you get.  What I mean by this is that you have to accept the supported K8S versions, features available.  If you need full control of your K8S deployment, say you want to use the latest version of K8S, control which vnet/subnet the masters and worker nodes are deployed, or you want to enable specific features, a different CNI plugin, etc, then you will need to use ACS Engine.

acs-engine is a tool that will generate the ARM (Azure Resource Manager) templates required to provision the compute, network, storage resources as well as extensions to deploy Docker and all the required K8S components.  It is important to note that what gets provisioned are IaaS resources.  Hence, you need to fully manage it - patching, hardening, backup, continuous monitering/alerting, etc.  However, if you want full control, ACS Engine is the way to go.  If you do not, or if you prefer to just focus on building applications and let Microsoft manage the infrastructure and K8S for you, then AKS is the way to go.

```sh
#1 Create the api model input to acs-engine.  This .json file configures the version of K8S that should be deployed as well as the number of agent nodes etc.  See k8s-1.9.json as an example

#2 Get the subscription id of the subscription you wish to use

az account list -o table

Name                                                       CloudName    SubscriptionId                        State    IsDefault
---------------------------------------------------------  -----------  ------------------------------------  -------  -----------
Learning - Jungho Kim                                      AzureCloud   f6de0a1c-8065-430a-92d0-2dd8fff75     Enabled  True

#3 Generate and deploy the ARM template.  This command will create a resource group with the same name as your dns-prefix then deploy the IaaS resources into the RG.  It will also generate the ARM templates, the certs/keys for all the control plane components, the kubectl client, as well as kubeconfig files to access each Azure region.  Look at the contents of the _output directory.  Note, if you want to just generate the output, replace deploy with generate.

acs-engine deploy --subscription-id <sub-id> --dns-prefix <your-dns-prefix> --location <region e.g. canadaeast> --api-model <your-api-model-json>

#4 Access the cluster using the kubeconfig for the region.  

export KUBECONFIG=`pwd`/_output/<dns-prefix>/kubeconfig/kubeconfig.<region>.json

kubectl cluster-info

#You should see something like this

Kubernetes master is running at https://architech-k8s2.eastus2.cloudapp.azure.com
Heapster is running at https://architech-k8s2.eastus2.cloudapp.azure.com/api/v1/namespaces/kube-system/services/heapster/proxy
KubeDNS is running at https://architech-k8s2.eastus2.cloudapp.azure.com/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
kubernetes-dashboard is running at https://architech-k8s2.eastus2.cloudapp.azure.com/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy
tiller-deploy is running at https://architech-k8s2.eastus2.cloudapp.azure.com/api/v1/namespaces/kube-system/services/tiller-deploy:tiller/proxy

```

## References ##

* [ACS Engine Git Repo](https://github.com/Azure/acs-engine)