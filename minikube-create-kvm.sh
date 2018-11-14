#!/bin/sh

# Documentation from https://mapr.com/blog/making-data-actionable-at-scale-part-2-of-3/

minikube start --memory 4096 --vm-driver=kvm2

# From https://continuous.lu/2017/04/28/minikube-and-helm-kubernetes-package-manager/
eval $(minikube docker-env)
minikube dashboard &

# install helm
curl -s https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash -s

helm init
helm search
helm install stable/mysql

