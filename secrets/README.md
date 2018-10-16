# Secrets #

Almost all applications have a need to access other services using sensitive data such as credentials or keys.  For non-senstive configuration data, you can just you configmaps but for things like credentials or keys you should use secrets.

**Note, K8S secrets base64 encodes the data.  You can enable etcd to encrypt the data at rest (see reference section below).  Alternatively, you can delegate secret management to solutions such as [Hashicorp Vault](https://www.vaultproject.io/) or Azure Keyvault**

```sh
#here we are creating a secret named 'example-secrets' from all the files in the directory 'secrets'
kubectl create secret generic example-secrets --from-file=secrets

#get the secret, notice the data is base64 encoded
kubectl get secrets/example-secrets -o yaml

#deploy a pod that will use the secret
kubectl create -f secret-pod.yaml

#exec into the pod and see the secrets available as files in /etc/secrets
kubectl exec -ti secret-pod -- sh

#in the pod shell run the following command
$ ls /etc/secrets
some-credentials  some-key
```

## ImagePullSecrets ##

You also use secrets to pull images from your private registry.  

```sh
#note the secret type is docker-registry
kubectl create secret docker-registry $secretname --docker-server=$server --docker-username=$username --docker-password=$password --docker-email=$email
```

You then reference the docker-registry secret from your pod manifest.

```yaml
spec:
  imagePullSecrets:
    name: "secret-name"
```

See [platform/azure-acr/README](../platform/azure-acr/README.md) for instructions on how to use [Azure Container Registry](https://docs.microsoft.com/en-us/azure/container-registry/) for your images.

## References ##

- [Secrets @ k8s.io](https://kubernetes.io/docs/concepts/configuration/secret/)
- [Encrypting Secrets in etcd](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/)