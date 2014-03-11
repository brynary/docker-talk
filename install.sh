#!/bin/bash
set -e

if which boot2docker > /dev/null; then
  echo "### boot2docker already installed"
else
  echo "### Installing boot2docker into /usr/local/bin"
  cd /tmp
  curl -s https://raw.github.com/boot2docker/boot2docker/9c583f90c4184ef9f838a3119897c3e9a7450ba8/boot2docker > boot2docker
  chmod +x boot2docker
  sudo mv boot2docker /usr/local/bin
fi

echo
if which docker > /dev/null; then
  echo "### docker client already installed"
else
  echo "### Installing docker client into /usr/local/bin"
  curl -s -o docker https://get.docker.io/builds/Darwin/x86_64/docker-0.8.0
  chmod +x docker
  sudo mv docker /usr/local/bin
fi

echo
if [ -z "$DOCKER_HOST" ]; then
  echo "### Setting up DOCKER_HOST ..."

  if grep -q DOCKER_HOST ~/.bashrc; then
    echo "    DOCKER_HOST already set in ~/.bashrc. Aborting."
  else
    echo "    Setting DOCKER_HOST in ~/.bashrc ..."
    echo 'export DOCKER_HOST=tcp://127.0.0.1:4243' >> ~/.bashrc
  fi
else
  echo "### Not setting DOCKER_HOST (already set)"
fi

export DOCKER_HOST='tcp://127.0.0.1:4243'

echo
echo "### boot2docker init"
boot2docker init || true

echo
echo "### boot2docker up"
boot2docker up

echo
echo "### docker pull busybox"
docker pull busybox

echo
echo "### docker run -i -t busybox /bin/echo hello world"
docker run -i -t busybox /bin/echo hello world
