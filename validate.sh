#!/bin/bash
set -e

sudo DEBIAN_FRONTEND=noninteractive apt update
sudo DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends python3-pip python3-venv git
python3 -m venv ansi-venv
source ansi-venv/bin/activate
pip3 -q install ansible-core botocore boto3

ansible-galaxy collection install community.aws
ansible-galaxy collection install amazon.aws
ansible-galaxy collection install ansible.posix

ansible-playbook playbooks/devcontainer.yml
