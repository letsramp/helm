#!/bin/bash
set -ex

CLUSTER_NAME=skyramp-debug
cat <<EOF | kind create cluster --name=${CLUSTER_NAME} -v7 --wait 1m --retain --config=-
apiVersion: kind.x-k8s.io/v1alpha4
kind: Cluster
nodes:
  - role: control-plane
    extraMounts:
      - hostPath: /Users/shinychimra/skyramp/skyramp/
        containerPath: /host-mount
EOF
