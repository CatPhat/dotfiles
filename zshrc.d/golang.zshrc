#!/usr/bin/env sh

export GOPATH="${ENV_GOPATH}"
export CGO_ENABLED="0"

export GOBIN="${ENV_GOPATH}/bin"
export PATH="$PATH:${ENV_GOPATH}/bin"
