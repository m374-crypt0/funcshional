#!/bin/env bash

set -o pipefail

transform_first() {
  local f="$1"
  local f_type &&
    f_type="$(type -t "$f")"

  if [ "$f_type" != 'function' ]; then
    return 1
  fi

  local arg &&
    arg="$2"

  local line
  while read -r line; do
    if [ -n "$line" ]; then
      "$f" "$line" "$arg"
    fi
  done
}

transform_last() {
  local f="$1"
  local f_type &&
    f_type="$(type -t "$f")"

  if [ "$f_type" != 'function' ]; then
    return 1
  fi

  local arg &&
    arg="$2"

  local line
  while read -r line; do
    if [ -n "$line" ]; then
      "$f" "$arg" "$line"
    fi
  done
}
