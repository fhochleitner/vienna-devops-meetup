#!/bin/bash

source ./pids
for pid in $ARGOCD_PID $WORKFLOWS_PID $EVENTSOURCE_PID $NGROK_PID; do
    kill $pid
done

rm ./pids

#minikube stop -p devops-meetup