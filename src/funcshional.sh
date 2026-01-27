#!/bin/env bash

set -o pipefail

# TODO: take into account empy elements
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
    if [ -n "$line" ]; then
      "$f" "$line" "${args_array[@]}"
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

  shift
  local args_array &&
    args_array=("$@")

  local line
  while IFS= read -r line; do
    if [ -n "$line" ]; then
      "$f" "${args_array[@]}" "$line"
    fi
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
    if [ -n "$line" ]; then
      accumulated="$("$f" "$line" "$accumulated" "${args_array[@]}")"
    fi
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
    if [ -n "$line" ]; then
      accumulated="$("$f" "${args_array[@]}" "$line" "$accumulated")"
    fi
  done

  echo "$accumulated"
}

# TODO: refacto as fold
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
