#!/bin/env sh
# Copyright (C) 2022 Temuri Takalandze.
# License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.
#
# Written by Temuri Takalandze.

set -e

function print_help() {
  cat <<EOF
Usage: httpinfo [OPTION]... STATUS_CODE
Display information about HTTP status codes.

-v, --version   output version information and exit
-h, --help      display this help and exit

Example:

httpinfo 200
EOF
}

function print_version() {
  cat <<EOF
httpinfo 1.0.0
Copyright (C) 2022 Temuri Takalandze.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Temuri Takalandze.
EOF
}

function print_status_code_description() {
  BASE_URL=https://developer.mozilla.org/en-US/docs/Web/HTTP/Status

  HTTP_RESPONSE=$(curl -s -o /tmp/httpinfo -w "%{http_code}" "$BASE_URL/$1")
  if [ "$HTTP_RESPONSE" -eq 404 ]; then
      echo "httpinfo: unknown HTTP Status Code $1"
      exit 2
  elif [ ! "$HTTP_RESPONSE" -eq 200 ]; then
      echo "httpinfo: unable to process request. Code: $HTTP_RESPONSE"
      exit 3
  fi

  TRIMMED_HTML=$(< /tmp/httpinfo tr -d '\n')
  rm -f /tmp/httpinfo

  ARTICLE_CONTENT=$(echo "$TRIMMED_HTML" | grep -o -P '<article class="main-page-content" lang="en-US">(.*?)<\/article>')
  TITLE=$(echo "$ARTICLE_CONTENT" | grep -o -P '(?<=<h1>).*(?=</h1>)')
  DESCRIPTION=$(echo "$ARTICLE_CONTENT" | grep -o -P '(?<=<div>).*(?=</div><h2 id="status">)')

  echo "$TITLE"
  repeat_text ${#TITLE} "="

  echo "$DESCRIPTION" | sed -e "s/<[p>]*>/\n\n/g" | sed -e "s/<[^>]*>//g"

  echo -e "\n"
  repeat_text "$(tput cols)" "-"
  echo -e "\n"

  echo -e "Read more at: $BASE_URL/$1"
}

function repeat_text() {
  for _ in $(seq 1 "$1"); do echo -n "$2"; done
}

POSITIONALS=()
while [[ $# -gt 0 ]]; do
  case $1 in
  -h | --help)
    print_help
    exit 0
    ;;
  -v | --version)
    print_version
    exit 0
    ;;
  -*)
    echo "httpinfo: unknown option '$1'"
    echo "Try 'httpinfo --help' for more information."
    exit 1
    ;;
  *)
    POSITIONALS+=("$1")
    shift
    ;;
  esac
done

set -- "${POSITIONALS[@]}"

if [ ! $# -eq 1 ]; then
  echo "httpinfo: invalid arguments count"
  echo "Try 'httpinfo --help' for more information."
  exit 1
fi

print_status_code_description "$1"
