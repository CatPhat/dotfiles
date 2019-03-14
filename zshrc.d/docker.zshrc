#!/bin/bash

# Aliases
docker_prune() {
	docker system prune --volumes -fa
}

# Completions
fpath=(~/.docker/completions "$fpath")
