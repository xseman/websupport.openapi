#!/bin/bash

for file in {dns,hosting,invoices,ordering,services,users,vps}; do
	./openapi-generator-cli.sh validate -i "../${file}.yaml"
done
