# Openshift Deployment on Azure #

Openshift is a Kubernetes distribution from RedHat.  It is based on an open source project led by RedHat called [Openshift Origin](https://www.openshift.org/).  RedHat provides a fully supported version called [Openshift Container Platform](https://www.openshift.com/products/container-platform/) that is based on the origin codebase.

Openshift builds on top of the core Kubernetes platform to add extensions that provide following:
- Web Console with project lifecycle/deployment management, user/group management
- Integrated log aggregation, monitoring (uses Prometheus, Fluentd)
- Integrated CI/CD with Jenkins
- Custom Resources such as ImageStream, BuildConfig, DeploymentConfig, Routes to provide some capabilities that are not in core Kubernetes (e.g. triggering build/deployment based on image or configuration change).  
- The project concept that wraps Kubernetes namespaces to apply security and resource consumption contraints in a simpler manner
- The oc CLI which is an extension of kubectl that aware of all the kubernetes resources as well as openshift resources

**Note, some of the custom Openshift resources have analogous resources in Kubernetes.  For example, Routes are analogous to Ingress rules, Routers are similar to Ingress Controllers.  However, some such as ImageStream and BuildConfig does not have an analogous resource in core K8S**

To see how Openshift extends Kubernetes, see [here](https://www.openshift.com/learn/topics/kubernetes/).
To see the custom API resources that openshift adds to Kubernetes see the [here](https://docs.openshift.com/container-platform/3.9/rest_api/index.html).  

To install Openshift on a Developer machine, see [here](DEV_INSTALL.md).
To install a multi-node Openshift cluster on Azure see [here](AZURE_INSTALL.md)

## Deploying the Todo App the Openshift Way ##

There are multiple ways to deploy applications to Openshift.  Which path you choose depends on the workflow.  As a Developer building and deploying applications to their local cluster, using the oc CLI or the Web Console is often sufficient.  However, for CI/CD you will need to take a different approach.

