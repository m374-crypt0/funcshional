to_foo() {
  echo foo
}

t_first_append() {
  local item="$1"

  echo "$item""$2""$3""$4"
}

t_last_append() {
  local item="$4"

  echo "$item""$1""$2""$3"
}
