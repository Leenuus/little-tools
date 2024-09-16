#!/bin/bash

index_url='https://googlechromelabs.github.io/chrome-for-testing/known-good-versions.json'

set -o pipefail

version=$(proxychains -q curl -s "$index_url" | jq -r '.versions.[] | .version' | fzf)

[ -z "$version" ] && {
	echo 'No version selected' >&2
	exit 1
}

download_url="https://storage.googleapis.com/chrome-for-testing-public/${version}/linux64/chrome-linux64.zip"

proxychains -q curl "$download_url" -o "$version-linux64.zip"
