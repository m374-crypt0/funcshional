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

sink_() {
  transform_first id_
}
