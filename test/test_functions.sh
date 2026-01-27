to_foo() {
  echo foo
}

t_first_append() {
  local item="$1"

  echo "$item""$2""$3"
}

t_last_append() {
  local item="$3"

  echo "$item""$1""$2"
}
