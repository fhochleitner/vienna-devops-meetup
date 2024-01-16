#!/bin/bash

# make sure minikube is running
#minikube start -p devops-meetup

# start port-forwards
kubectl port-forward -n devops-tools svc/argocd-server 8080:443 &
ARGOCD_PID=$!

kubectl port-forward -n devops-tools svc/argo-workflows-server 8081:2746 &
WORKFLOWS_PID=$!

kubectl port-forward -n events svc/demo-microservice-configurator-eventsource-svc 12000:12000 &
EVENTSOURCE_PID=$!


echo ARGOCD_PID=$ARGOCD_PID >> pids
echo WORKFLOWS_PID=$WORKFLOWS_PID >> pids
echo EVENTSOURCE_PID=$EVENTSOURCE_PID >> pids

echo -n "ARGOCD PASS "
kubectl get secret -n devops-tools argocd-initial-admin-secret -o jsonpath="{ .data.password }" | base64 -d && echo
echo -n " "


ngrok http 12000 &
NGROK_PID=$!
echo NGROK_PID=$NGROK_PID >> pids
