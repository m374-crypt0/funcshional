to_foo() {
  echo foo
}

t_first_append() {
  local item="$1"
  local arg="$2"

  echo "$item""$arg"
}

t_last_append() {
  local arg="$1"
  local item="$2"

  echo "$item""$arg"
}
