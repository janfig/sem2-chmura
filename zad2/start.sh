#!/bin/sh
minikube kubectl -- create ns zad2
find ./config -name '*.yaml' -exec minikube kubectl -- apply -f {} \;
minikube kubectl -- apply -f operator-stepcd.yaml
curl -H "Host: lab2.zad" $(minikube service -n zad2 webapp-svc --url)
