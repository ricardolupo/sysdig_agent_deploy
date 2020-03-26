#!/bin/bash

kubectl create ns sysdig-agent
kubectl create secret generic sysdig-agent --from-literal=access-key=$1 -n sysdig-agent
kubectl apply -f sysdig-agent-clusterrole.yaml -n sysdig-agent
kubectl create serviceaccount sysdig-agent -n sysdig-agent
kubectl create clusterrolebinding sysdig-agent --clusterrole=sysdig-agent --serviceaccount=sysdig-agent:sysdig-agent
kubectl apply -f agent_config.yaml -n sysdig-agent
kubectl apply -f sysdig-agent-daemonset-v2.yaml -n sysdig-agent
kubectl apply -f sysdig-agent-service.yaml -n sysdig-agent
sleep 2
watch kubectl get pods -n sysdig-agent -o wide
