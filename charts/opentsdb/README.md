## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

    helm repo add skyramp https://letsramp.github.io/helm/

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
skyramp` to see the charts.

To install the opentsdb chart:

    helm install my-opentsdb skyramp/opentsdb -n skyramp

To uninstall the chart:

    helm delete my-wopentsdb
