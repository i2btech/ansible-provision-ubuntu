# Provision Ubuntu

This repo provide ansible playbooks to provision diferent profiles of Ubuntu OS used in I2B:

- workstation: Local machine, this could be a virtual machine or a physical machine
- jenkins-agent: VM that run Jenkins jobs on AWS EC2
- devcontainer: Container that is used to run tools to manage the infrastructure and operation of environments

# Usage Workstation

```
sudo apt update
sudo apt install -y --no-install-recommends python3-pip python3-venv git
python3 -m venv ansi-venv
source ansi-venv/bin/activate
pip3 -q install ansible-core

ansible-galaxy collection install ansible.posix

ansible-pull -U https://github.com/i2btech/ansible-provision-ubuntu playbooks/workstation.yml

deactivate
rm -rf ansi-venv
```

# Development

## build base image
```
docker build -f Dockerfile.base --progress plain --tag i2btech/provision-ubuntu:base ./
```

## validate provision automatically
```
docker build -f Dockerfile.validate --progress plain --tag i2btech/provision-ubuntu:validate ./
```

## validate provision manually

### create temporary container
```
docker run \
  -it \
  --rm \
  -v $PWD/:/workdir \
  --workdir /workdir \
  --name provision-ubuntu \
  --hostname provision-ubuntu \
  i2btech/provision-ubuntu:base \
  /bin/bash

## run playbook
./validate.sh
```