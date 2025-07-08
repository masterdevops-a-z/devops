#!/bin/bash

 ######################################################################################
# Author: Sandeep Kumar                                                               #
# Description: This script is to list all the users present in a GitHub Respository   #
# Date: 08 July 2025                                                                  #
# Version: V1                                                                         #
#######################################################################################

function helper {
	if (( $# != 2 )); then 
		echo "❌ Please enter correct command line arguments"
		echo "✅ Usage: ./list_users.sh <owner> <repo>"
		exit 1
	fi
}

helper "$@"

owner="$1"
repo="$2"

name="$username"
tok="$token"

api_url="https://api.github.com/repos/$owner/$repo/collaborators"

function get_github_api {

	curl -s -u "$name:$tok" "$api_url"

}

function list_users {

	collaborators="$( get_github_api | jq -r '.[].login' )"

	if [[ -z "$collaborators" ]]; then
		echo "There are no users found in $owner/$repo"
	else
		echo "The list of users in $owner/$repo :"
		echo "$collaborators"
	fi
}

list_users
