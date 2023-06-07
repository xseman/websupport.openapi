#!/bin/bash

hash_hmac() {
	data="${1}"
	key="${2}"
	shift 2
	echo -n "$data" | openssl dgst -sha1 -hmac "${key}" "$@"
}

api="https://rest.websupport.sk"
method="GET"
path="/v1/user"
query=""

# websupport: Personal settings -> Security and login 
apiKey=""
secret=""

signature=$(hash_hmac "${method} ${path} $(date +%s)" "${secret}")

echo "${apiKey}:$(echo "${signature}" | cut -d " " -f2)"
echo "$(date +%Y%m%dT%H%M%SZ --utc)"

curl "${api}${path}${query}" \
	-u "${apiKey}:$(echo "${signature}" | cut -d " " -f2)" \
	-H "Date: $(date +%Y%m%dT%H%M%SZ --utc)" \
	-H "Accept: application/json" \
	-H "Content-Type: application/json"

