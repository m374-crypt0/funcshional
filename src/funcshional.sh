#!/bin/env bash

set -o pipefail

transform_first() {
  local f="$1"

  if [ -z "$f" ]; then
    return 1
  fi
}

transform_last() {
  local f="$1"

  if [ -z "$f" ]; then
    return 1
  fi
}
