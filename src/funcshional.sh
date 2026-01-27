#!/bin/env bash

set -o pipefail

transform_first() {
  local f="$1"
  local f_type &&
    f_type="$(type -t "$f")"

  if [ "$f_type" != 'function' ]; then
    return 1
  fi

  shift
  local args_array &&
    args_array=("$@")

  local line
  while IFS= read -r line; do
    "$f" "$line" "${args_array[@]}" ||
      return 1
  done
}

transform_last() {
  local f="$1"
  local f_type &&
    f_type="$(type -t "$f")"

  if [ "$f_type" != 'function' ]; then
    return 1
  fi

  shift
  local args_array &&
    args_array=("$@")

  local line
  while IFS= read -r line; do
    "$f" "${args_array[@]}" "$line" ||
      return 1
  done
}

fold_first() {
  local f="$1"
  local f_type &&
    f_type="$(type -t "$f")"

  if [ "$f_type" != 'function' ]; then
    return 1
  fi

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
    accumulated="$("$f" "$line" "$accumulated" "${args_array[@]}")" ||
      return 1
  done

  echo "$accumulated"
}

fold_last() {
  local f="$1"
  local f_type &&
    f_type="$(type -t "$f")"

  if [ "$f_type" != 'function' ]; then
    return 1
  fi

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
    accumulated="$("$f" "${args_array[@]}" "$line" "$accumulated")" ||
      return 1
  done

  echo "$accumulated"
}

take() {
  local n &&
    n="$1"

  if ! ((n + 0)); then
    return 1
  fi

  if [ "$n" -lt 0 ]; then
    return 1
  fi

  local line
  while IFS= read -r line; do
    if [ "$n" -gt 0 ]; then
      echo "$line"
      n=$((n - 1))
    fi
  done
}

id() {
  echo "$@"
}

sink() {
  transform_first id
}

skip() {
  local n &&
    n="$1"

  if ! ((n + 0)); then
    return 1
  fi

  if [ "$n" -lt 0 ]; then
    return 1
  fi

  while [ "$n" -gt 0 ]; do
    n=$((n - 1))
    read -r
  done

  sink
}
