#!/bin/bash

input=$1
appName=$( echo "$input" |cut -d'-' -f1 )
env=$( echo "$input" |cut -d'-' -f2 )
version=$( echo "$input" |cut -d'-' -f3 )"-"$( echo "$input" |cut -d'-' -f4 )

#Setting up vault endpoint
export VAULT_ADDR='https://127.0.0.1:8300'

# Writing secrets into Vault
$HOME/programs/servers/vault/vault write secret/$appName-$version,$env @$input

