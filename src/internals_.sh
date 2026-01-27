is_function_() {
  local f="$1"
  local f_type &&
    f_type="$(type -t "$f")"

  if [ "$f_type" != 'function' ]; then
    return 1
  fi
}

discard_() {
  local line
  while read -r line; do
    if [ -n "$line" ]; then
      break
    fi
  done
}

id_() {
  echo "$@"
}

append_to_() {
  local stream &&
    stream="$1"

  local line &&
    line="$2"

  if [ -z "$stream" ]; then
    stream="$line"
  else
    stream="$stream"$'\n'"$line"
  fi

  echo "$stream"
}

is_positive_integer_() {
  local n &&
    n="$1"

  if ! ((n + 0)); then
    return 1
  fi

  if [ "$n" -lt 0 ]; then
    return 1
  fi
}
