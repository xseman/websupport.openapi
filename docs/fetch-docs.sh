#!/bin/bash

wget -q \
	--show-progress \
	--timestamping \
	--adjust-extension \
	-i downloads.txt

find . -name "v1.*.html" -print0 | while IFS= read -r -d '' file; do
	pandoc \
		"$file" \
		-o "${file%.html}.md" \
		--from html \
		--to markdown \
		--wrap=none \
		--strip-comments && rm "${file}"
done
