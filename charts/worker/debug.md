# Dev debug ow worker

This branch provides a local debugging of Skyramp Worker by
creating a local kind cluster with host mounted sources and openvscode server

Prerequisites

[just command runner](https://just.systems/man/en/chapter_5.html)

```
brew install just
```


## Workflow

### Open file create-debug-cluster.sh

Update path to skyramp git repositoru
```
#!/bin/bash
set -ex

CLUSTER_NAME=skyramp-debug
cat <<EOF | kind create cluster --name=${CLUSTER_NAME} -v7 --wait 1m --retain --config=-
apiVersion: kind.x-k8s.io/v1alpha4
kind: Cluster
nodes:
  - role: control-plane
    extraMounts:
      - hostPath: /Users/pedro/git/letsramp/skyramp/
        containerPath: /host-mount
EOF
```

### Create a new cluster
```
./create-debug-cluster.sh
skyramp config add-kubeconfig ~/.kube/config
```

### Inspect justfile containerPath
```
observe default namespace as skyramp
```

### Deploy Worker 
```
just install
```


### Perform port forwarding
```
just port-forward
```

### Open VSCode in browser http://localhost:8080
[http://localhost:8080](http://localhost:8080)


### Open Skyramp repo mounted as /root/skyramp 

### Add cleanup task to worker
/root/skyramp/.vscode/tasks.json

```
{
    "version": "2.0.0",
    "tasks": [
      {
        "label": "cleanup-plugins",
        "type": "shell",
        "command": "rm -f /usr/local/lib/skyramp/idl/grpc/skyramp*.*",
        "problemMatcher": []
      },
      {
        "label": "delete-mocks",
        "type": "shell",
        "command": "rm -f /usr/local/lib/skyramp/idl/grpc/skyramp*.*",
        "problemMatcher": []
      }
    ]
  }
```

### Add Debug Worker to VSCode launch configuration

/root/skyramp/.vscode/launch.json
```
        {
            "name": "Debug Worker",
            "type": "go",
            "request": "launch",
            "mode": "auto",
            "program": "${workspaceFolder}/cmd/worker",
            "cwd": "/root",
            "preLaunchTask": "cleanup-plugins",
            "restart": true,
            "console": "integratedTerminal",
            "env": {
                "DEBUGGER" : "true",
                "PATH": "${env:PATH}:/go/bin"
            },
        },

```
