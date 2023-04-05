#!/bin/ash


set -eu

export PLATFORM="github"

RESULT=$(/k8sgpt analyze --explain)
echo "RESULT=$RESULT" >> $GITHUB_OUTPUT
