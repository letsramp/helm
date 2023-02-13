# mocker-helm
Helm chart for Mocker

## Usage
To use this Helm chart on an existing Kubernetes cluster, run the following within the repository root:
```
helm install -n <desired namespace> <name of release> .
```

For example:
```
helm install -n my-application-namespace my-skyramp-mocker .
```
