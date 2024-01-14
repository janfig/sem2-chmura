#!/bin/sh
minikube kubectl -- create ns zad2
find ./config -name '*.yaml' -exec minikube kubectl -- apply -f {} \;
minikube kubectl -- apply -f operator-stepcd.yaml
