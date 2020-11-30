#!/usr/bin/env bash

function usage {
  cat <<EOF
  Usage: $(basename $0) message

  Check if message conforms to a conventional commit message, see
  https://www.conventionalcommits.org/en/v1.0.0/#specification

EOF
}

if [[ -z "$1" ]]; then
	usage
	exit 1
fi
msg="$1"

regexp='^(fix|feat|chore|docs)(\([[:alnum:]_]+\))?!?:[[:space:]][^[:space:]](.*)[^.]$'
if [[ ! "$msg" =~ $regexp ]]; then
	echo "bad commit message: \"$msg\""
	exit 1
fi
