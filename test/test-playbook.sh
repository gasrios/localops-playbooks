#!/usr/bin/env sh

set -eu

export PLAYBOOK=$(echo $1 | sed 's|^\.\./||')

cd ..

if [ $(ansible-lint --profile=min $PLAYBOOK; echo $?) -eq 0 ]
then
  echo 'Static code check found no errors'
fi

for DISTRO in debian-bookworm debian-trixie ubuntu-22.04 ubuntu-24.04
do
  echo "Testing $PLAYBOOK on $DISTRO..."
  docker run \
    --rm \
    -it \
    -u test \
    -v $(pwd):/home/test/localops-playbooks \
    -w /home/test \
    localops:${DISTRO} \
    "''. ~/.profile && localops localops-playbooks/$PLAYBOOK localops-playbooks/$PLAYBOOK''"
done
