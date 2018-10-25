#!/bin/sh

git clone https://github.com/kubernetes-incubator/kubespray.git

cp -va kubespray/inventory/local  kubespray/inventory/kube-cluster

cp kubespray.inventory.kube-cluster.hosts.ini kubespray/inventory.kube-cluster.hosts.ini 
