setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${FUNCSHIONAL_ROOT_DIR}test/test_helper/bats-support/load"
  load "${FUNCSHIONAL_ROOT_DIR}test/test_helper/bats-assert/load"

  load "${FUNCSHIONAL_ROOT_DIR}"src/hof/filter.sh
  load "${FUNCSHIONAL_ROOT_DIR}"test/test_functions.sh
}

teardown() {
  :
}

@test 'filter_first fails if first argument is not a function' {
  run --keep-empty-lines bats_pipe echo 'a
b

c' \| \
    filter_first foo

  assert_equal $status "$FUNCSHIONAL_INVALID_FILTER_PREDICATE"
}

@test 'filter_first works for argument-less predicate for empty stream' {
  run bats_pipe echo '


' \| \
    filter_first only_letter

  assert_output ''
}

@test 'filter_first works for argument-less predicate filtering non empty input' {
  run --keep-empty-lines bats_pipe echo 'a
b

c' \| \
    filter_first only_letter

  assert_output $'a\nb\nc\n'
}

@test 'filter_first works for predicate with arguments' {
  run bats_pipe echo 'a
b
c
d
e
f' \| \
    filter_first only a b c

  assert_output $'a\nb\nc'
}
