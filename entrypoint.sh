#!/bin/ash


set -eu

export PLATFORM="github"

RESULT=$(k8sgpt version)
echo $RESULT
echo "RESULT=$RESULT" >> $GITHUB_OUTPUT
