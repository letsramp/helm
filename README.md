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

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

helm repo add skyramp https://letsramp.github.io/helm-charts

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
skyramp` to see the charts.

To install the mocker chart:

    helm install my-mocker skyramp/mocker

To uninstall the chart:

    helm delete my-mocker