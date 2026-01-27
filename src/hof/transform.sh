#!/bin/env bash

set -o pipefail

# shellcheck source=../internals_.sh
. "${FUNCSHIONAL_ROOT_DIR}"src/internals_.sh

transform_first() {
  local f &&
    is_function_ "$1" ||
    return $? &&
    f="$1"

  shift
  local args_array &&
    args_array=("$@")

  local line
  while IFS= read -r line; do
    if [ -n "$line" ]; then
      local r &&
        r="$("$f" "$line" "${args_array[@]}")" ||
        return 1 &&
        [ "$(wc -l <<<"$r")" -eq 1 ] ||
        return 1 &&
        echo "$r"
    fi
  done
}

transform_last() {
  local f &&
    is_function_ "$1" ||
    return $? &&
    f="$1"

  shift
  local args_array &&
    args_array=("$@")

  local line
  while IFS= read -r line; do
    if [ -n "$line" ]; then
      local r &&
        r="$("$f" "${args_array[@]}" "$line")" ||
        return 1 &&
        [ "$(wc -l <<<"$r")" -eq 1 ] ||
        return 1 &&
        echo "$r"
    fi
  done
}
