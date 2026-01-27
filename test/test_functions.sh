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

as_decorated_string_first() {
  local prefix &&
    prefix="$3"

  local suffix &&
    suffix="$4"

  if [ -z "$2" ]; then
    echo "$prefix$1$suffix"
  else
    echo "$2 $prefix$1$suffix"
  fi
}

as_decorated_string_last() {
  local prefix &&
    prefix="$1"

  local suffix &&
    suffix="$2"

  if [ -z "$4" ]; then
    echo "$prefix$3$suffix"
  else
    echo "$4 $prefix$3$suffix"
  fi
}

no_op_success() {
  :
}

wrong_outputing_transformer() {
  # NOTE: wrong because outputing 2 lines for 1 input stream item
  echo foo
  echo bar
}

only() {
  local item &&
    item="$1"

  [ "$item" = "$2" ] ||
    [ "$item" = "$3" ] ||
    [ "$item" = "$4" ]
}

only_last() {
  local item &&
    item="$4"

  [ "$item" = "$1" ] ||
    [ "$item" = "$2" ] ||
    [ "$item" = "$3" ]
}

only_letter() {
  [[ "$1" =~ [a-zA-Z] ]]
}
