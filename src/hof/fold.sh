#!/bin/env bash

set -o pipefail

# shellcheck source=../internals_.sh
. "${FUNCSHIONAL_ROOT_DIR}"src/internals_.sh

fold_first() {
  local f &&
    is_function_ "$1" ||
    return $? &&
    f="$1"

  if [ $# -lt 2 ]; then
    return 1
  fi

  local accumulated &&
    accumulated="$2"

  shift 2
  local args_array &&
    args_array=("$@")

  local line
  while IFS= read -r line; do
    if [ -n "$line" ]; then
      accumulated="$("$f" "$line" "$accumulated" "${args_array[@]}")" ||
        return 1
    fi
  done

  echo "$accumulated"
}

fold_last() {
  local f &&
    is_function_ "$1" ||
    return $? &&
    f="$1"

  if [ $# -lt 2 ]; then
    return 1
  fi

  local accumulated &&
    accumulated="$2"

  shift 2
  local args_array &&
    args_array=("$@")

  local line
  while IFS= read -r line; do
    if [ -n "$line" ]; then
      accumulated="$("$f" "${args_array[@]}" "$line" "$accumulated")" ||
        return 1
    fi
  done

  echo "$accumulated"
}
