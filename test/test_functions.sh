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

as_string() {
  if [ -z "$2" ]; then
    echo "$1"
  else
    echo "$2 $1"
  fi
}
