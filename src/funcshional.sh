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
      local r &&
        r="$("$f" "${args_array[@]}" "$line")" ||
        return 1 &&
        [ "$(wc -l <<<"$r")" -eq 1 ] ||
        return 1 &&
        echo "$r"
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
      accumulated="$("$f" "$line" "$accumulated" "${args_array[@]}")" ||
        return 1
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
      accumulated="$("$f" "${args_array[@]}" "$line" "$accumulated")" ||
        return 1
    fi
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
    if [ -n "$line" ]; then
      if [ "$n" -gt 0 ]; then
        echo "$line"
        n=$((n - 1))
      fi
    fi
  done
}

id() {
  echo "$@"
}

sink() {
  transform_first id
}

discard() {
  local line
  while read -r line; do
    if [ -n "$line" ]; then
      break
    fi
  done
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
    discard
    n=$((n - 1))
  done

  sink
}

prepend() {
  echo "$@"

  sink
}

append() {
  sink

  echo "$@"
}

filter_first() {
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
      if "$f" "$line" "${args_array[@]}"; then
        echo "$line"
      fi
    fi
  done
}

filter_last() {
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
      if "$f" "${args_array[@]}" "$line"; then
        echo "$line"
      fi
    fi
  done
}

partition_first() {
  local f="$1"
  local f_type &&
    f_type="$(type -t "$f")"

  if [ "$f_type" != 'function' ]; then
    return 1
  fi

  shift
  local args_array &&
    args_array=("$@")

  local top_size &&
    top_size=0
  local top
  local bottom
  local line

  while IFS= read -r line; do
    if [ -n "$line" ]; then
      if "$f" "$line" "${args_array[@]}"; then
        top_size=$((top_size + 1))

        if [ -z "$top" ]; then
          top="$line"
        else
          top="$top"$'\n'"$line"
        fi
      else
        if [ -z "$bottom" ]; then
          bottom="$line"
        else
          bottom="$bottom"$'\n'"$line"
        fi
      fi
    fi
  done

  if [ "$top_size" -gt 0 ]; then
    echo "$top_size"
    echo "$top"
    if [ -n "$bottom" ]; then
      echo "$bottom"
    fi
  fi
}

partition_last() {
  local f="$1"
  local f_type &&
    f_type="$(type -t "$f")"

  if [ "$f_type" != 'function' ]; then
    return 1
  fi

  shift
  local args_array &&
    args_array=("$@")

  local top_size &&
    top_size=0
  local top
  local bottom
  local line

  while IFS= read -r line; do
    if [ -n "$line" ]; then
      if "$f" "${args_array[@]}" "$line"; then
        top_size=$((top_size + 1))

        if [ -z "$top" ]; then
          top="$line"
        else
          top="$top"$'\n'"$line"
        fi
      else
        if [ -z "$bottom" ]; then
          bottom="$line"
        else
          bottom="$bottom"$'\n'"$line"
        fi
      fi
    fi
  done

  if [ "$top_size" -gt 0 ]; then
    echo "$top_size"
    echo "$top"
    if [ -n "$bottom" ]; then
      echo "$bottom"
    fi
  fi
}
