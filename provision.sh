#!/bin/sh

set -x
set -e

# . ~/.sidecar-env.sh

ansible-playbook -vvvv --ask-sudo-pass -i ansible/inventory/sidecar ansible/install-playbook.yml
