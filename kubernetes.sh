#!bin/bash

# Install Docker
yum install docker -y



# Install helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install k3d
wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

# Install helmfile
wget https://github.com/roboll/helmfile/releases/download/v0.142.0/helmfile_linux_amd64 
chmod +x helmfile_linux_amd64
mv helmfile_linux_amd64 /usr/local/bin/helmfile

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Create ad hoc config file
export KUBECONFIG=~/.k3d/k3s-default-config

#Clone repo
yum install git -y
git clone https://github.com/patoarvizu/freqtrade-helm-chart.git


# Open test folder
cd freqtrade-helm-chart/test-local/

# Launch deployment
make cluster
make sync

# Wait until all pods are Running or Completed.
kubectl -n freqtrade get pods