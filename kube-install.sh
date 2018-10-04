#!/bin/sh

# Follow documentation at:
# Documentation from https://dzone.com/articles/kubespray-10-simple-steps-for-installing-a-product

# Additional help:
# http://kubespray.io/apocng/index.html
# https://github.com/kubespray/kubespray-cli

git clone https://github.com/kubernetes-incubator/kubespray.git
cd kubespray
sudo pip install -r requirements.txt

ansible-playbook -u glbrimhall --become -i inventory/kube-cluster/hosts.ini cluster.yml  

# Check health:

kubectl get nodes

# Install dashboard at: https://github.com/kubernetes/dashboard

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

kubectl proxy

# Browses to http://kube1:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
