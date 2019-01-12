#!/bin/sh

set -e

git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
    while read path_key path 
    do
        url_key=$(echo $path_key | sed 's/\.path/.url/')
        url=$(git config -f .gitmodules --get "$url_key")
	name=$(git config -f .gitmodules --name-only --get-regexp "$url_key" | awk -F"." '{print $2}') 
       	git submodule add --name $name $url $path 
    done
