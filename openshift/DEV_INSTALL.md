# Installing Openshift locally on a Developer Machine #

There are multiple options for installing openshift origin on a developer machine.  The most popular are the following:

* [minishift](https://github.com/minishift/minishift) which is a fork of the popular [minikube](https://github.com/kubernetes/minikube) project
* The `oc cluster` command 

For the differences between the various approaches see the following blog [article](https://www.redhat.com/en/blog/five-openshift-development-environments-five-minutes).

We will be using the `oc` CLI approach as it allows you to deploy both Openshift Origin as well as the Enterprise Openshift Container Platform on RHEL.  The oc cli is supported on Windows, macOS and Linux, the only requirement is you need docker installed as `oc cluster up` deploys openshift using containers.  See [here](https://github.com/openshift/origin/blob/master/docs/cluster_up_down.md) for details.

Install docker for your operating system prior to running the cluster.

* For [Windows](https://docs.docker.com/docker-for-windows/install/)
* For [macOS](https://docs.docker.com/docker-for-mac/install/)
* For [Ubuntu](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#docker-ee-customers)

You will also have to set the following flag for your docker daemon to be able to pull images from the local registry deployed with openshift.

`--insecure-registry 172.30.0.0/16`

How you do so differs depending on the OS you are using.

* For macOS, you need to go to Docker --> Preferences --> Daemons
* For Linux, you add the following to the `/etc/docker/daemon.json` file

```json
{
    "insecure-registries" : ["172.30.0.0/16"]
}
```
* For Windows, see the following [docs](https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-docker/configure-docker-daemon)

For macOS you will need to also install the `socat` command line utility to proxy into the cluster.  You can install with brew.

`brew install socat`

## Download the oc client ##

Download the client from [here](https://github.com/openshift/origin/releases) (get the latest release) and put it in your PATH.

Run `oc version` to make sure it is on your PATH.  You should see something like this:

```sh
oc version
  
oc v3.9.0+191fece
kubernetes v1.9.1+a0ce1bc657
features: Basic-Auth GSSAPI Kerberos SPNEGO
```

## Start up Openshift Origin ##

**TIP:  use `oc cluster up --help` for explanation of all options.**

```sh
#This will start up a local cluster with default cluster configuration.
oc cluster up

#You can control which host OS to use and where do store the configuration
#when you initially bring up the cluster.  This is helpful, if you want multiple
#clusters on your system for testing
oc cluster up --image-streams=centos7 \
  --image=openshift/origin \
  --use-existing-config \
  --host-data-dir=${HOME}/openshift/data  \
  --host-config-dir=${HOME}/openshift/config  \
  --version=latest
```

The `host-data-dir` and `host-config-dir` bears further explanation.  These options are used to specify specific locations to store your cluster state and configuration.  Specifically, the data in etcd and your cluster access configuration respectively.  If you will be deploying multiple versions of the cluster on your local machine, specify these explicitly.

## Login to the Web Console ##

The `oc cluster up` command will output the URL to your local web console as well as the credentials to use.  The password will be set when you initial use it.

```sh
The server is accessible via web console at:
    https://127.0.0.1:8443

You are logged in as:
    User:     developer
    Password: <any value>

To login as administrator:
    oc login -u system:admin
```






