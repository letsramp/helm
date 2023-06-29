# Prometheus Operator

# Add repo
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts 
helm repo update 
```


## Download  Dependencies
```
helm dependency update

```

## Install Chart
```
helm install prom --namespace skyramp .
```


## Grafana

```
kubectl port-forward <grafana pod> -n skyramp 3000:3000
```

### Grafana UI
```
http://localhost:3000

username: admin
password: prom-operator
```

