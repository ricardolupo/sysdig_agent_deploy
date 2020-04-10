#!/bin/bash

kubectl create ns sysdig-agent
kubectl create secret generic sysdig-agent --from-literal=access-key=8740e988-faad-4327-a0be-ea63b5a4735d -n sysdig-agent
# 8740e988-faad-4327-a0be-ea63b5a4735d is for the ricardo.lupo@sysdig.com
# This is a placeholder for SNI/Selfhosted installs
#kubectl create secret generic sysdig-agent --from-literal=access-key=a3df0cb9-c17e-499f-b130-aaf359b954a4 -n sysdig-agent
# This is a placeholder for +kube account
#kubectl create secret generic sysdig-agent --from-literal=access-key=a3df0cb9-c17e-499f-b130-aaf359b954a4 -n sysdig-agent
kubectl apply -f sysdig-agent-clusterrole.yaml -n sysdig-agent
kubectl create serviceaccount sysdig-agent -n sysdig-agent
kubectl create clusterrolebinding sysdig-agent --clusterrole=sysdig-agent --serviceaccount=sysdig-agent:sysdig-agent
kubectl apply -f sysdig-agent-configmap.yaml -n sysdig-agent
kubectl apply -f sysdig-agent-daemonset-appsv1.yaml -n sysdig-agent
sleep 2
watch kubectl get pods -n sysdig-agent -o wide
