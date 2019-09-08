#!/bin/bash -xe
key_path=$1
tags=$2
playbook_name=$3
ansible-playbook -i hosts --private-key=${key_path} --tags=${tags} ${playbook_name}
