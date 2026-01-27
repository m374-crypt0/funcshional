#!/bin/env bash

set -o pipefail

# shellcheck source=../hof/transform.sh
. "${FUNCSHIONAL_ROOT_DIR}"src/hof/transform.sh

take() {
  local n &&
    is_positive_integer_ "$1" ||
    return 1 &&
    n="$1"

  local line
  while IFS= read -r line; do
    if [ -n "$line" ]; then
      if [ "$n" -gt 0 ]; then
        echo "$line"
        n=$((n - 1))
      fi
    fi
  done
}

skip() {
  local n &&
    is_positive_integer_ "$1" ||
    return 1 &&
    n="$1"

  while [ "$n" -gt 0 ]; do
    discard_
    n=$((n - 1))
  done

  sink_
}

prepend() {
  echo "$@"

  sink_
}

append() {
  sink_

  echo "$@"
}
