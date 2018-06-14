#!/bin/sh

set -x
set -e

# . ~/.sidecar-env.sh

ANSIBLE_PIPELINING=true DEFAULT_INTERNAL_POLL_INTERVAL=0.5 DEFAULT_FORKS=1 ansible-playbook -v -i ansible/inventory/sidecar ansible/join-playbook.yml
