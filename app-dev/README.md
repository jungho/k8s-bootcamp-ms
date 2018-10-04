# App Dev Workflow on Kubernetes - WIP #

Deploying your applications to Kubernetes once it is fully tested is one thing, what about when you are actively developing your applications and they require multiple dependencies?  Ideally, the developer experience should not require the developers to be experts in Kubernetes and the deployment knowledge is codified into a CI/CD pipeline.  This is an area that is actively being explored and there are many tools that are being developed to address this.  The challenge, however, is that there are 1) many tools! 2) there is often overlap in the tools 3) there is no clear end-to-end guidance.  This results in many development groups coming up with different processes.  The good thing is that this is a very active area of [research by the community](https://groups.google.com/forum/#!msg/kubernetes-dev/YcjXRDrCdbI/LKmUJX6YBgAJ).

Below I will cover at a high-level several tools that we have been investigating and that you should be aware of.

* Draft 
* Skaffold
* Telepresence

**Note, all these projects are all pre-stable stage!!  Things are moving fast any functionality can change, break, blow up etc.**

## Draft - DEPRECATED.##

[Draft](https://github.com/Azure/draft/blob/master/docs/reference/dep-003.md) is an open-source tool lead by Microsoft that aims to make it much simpler for developers to build applications that would be deployed to Kubernetes.  

## Running the Example ##

The instructions to install draft for your system is located [here](https://github.com/Azure/draft/blob/master/docs/install.md).  We will do couple things a bit differently.

1. We will use DockerHub as the registry, so create a free account at https://hub.docker.com/
2. We will deploy to an RBAC enabled cluster, in this case minikube.
3. We will enable ingress

Once you have installed draft, [helm](https://github.com/kubernetes/helm), and kubectl, and started up [minikube with RBAC enabled](../bootcamp/exercises/README.md), enable the ingress addon.

```sh 
minikube addons enable ingress
```

Then run the script `./init-draft.sh`.  This script will initilize helm, and draft with all the necessary permissions to deploy resources to the draft namespace.

After you have initialized helm and draft, run the commands below. 

```sh
draft create todo-ui
```

## Skaffold ##

[Skaffold](https://github.com/GoogleCloudPlatform/skaffold) is a tool from Google that is similar to Draft, however, it takes a very different approach.  Whereas Draft deploys a component called draftd onto the cluster, skaffold does not.  Furthermore, Draft requires Helm, skaffold does not.  In addition, skaffold can support development of multiple microservices at once, while Draft works with only one containerized app at a time.  For this reason alone, I believe  skaffold is a much more compelling tool at the moment when compared to draft.

**Note, the draft team has recently made a big change.  They have removed draftd, a key component, in the latest version of draft.  I think this is actually a very good thing. Therefore, for now, I recommend that you focus on skaffold as it seems the most mature**

## Telepresence - WIP ##

