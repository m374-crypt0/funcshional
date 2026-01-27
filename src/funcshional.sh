#!/bin/env bash

set -o pipefail

transform_first() {
  local f="$1"

  if [ -z "$f" ]; then
    return 1
  fi

  local line
  while read -r line; do
    if [ -n "$line" ]; then
      echo foo
    fi
  done
}

transform_last() {
  local f="$1"

  if [ -z "$f" ]; then
    return 1
  fi

  local line
  while read -r line; do
    if [ -n "$line" ]; then
      echo foo
    fi
  done
}
