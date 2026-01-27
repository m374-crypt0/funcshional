setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${FUNCSHIONAL_ROOT_DIR}test/test_helper/bats-support/load"
  load "${FUNCSHIONAL_ROOT_DIR}test/test_helper/bats-assert/load"

  load "${FUNCSHIONAL_ROOT_DIR}"src/hof/fold.sh
  load "${FUNCSHIONAL_ROOT_DIR}"test/test_functions.sh
}

teardown() {
  :
}

@test 'fold_first fails if not passed with an accumulator function' {
  run bats_pipe echo \| \
    fold_first unexisting_function

  assert_equal $status "$FUNCSHIONAL_INVALID_FOLD_REDUCER"
}

@test 'fold_first fails if not passed an initial accumulator value' {
  run bats_pipe echo \| \
    fold_first as_string

  assert_equal $status "$FUNCSHIONAL_MISSING_FOLD_ACCUMULATOR"
}

@test 'fold_first fails if the accumulator function fails' {
  run bats_pipe echo a \| \
    fold_first no_op_fail ''

  assert_equal $status "$FUNCSHIONAL_FOLD_REDUCER_INVOCATION_ERROR"
}

@test 'fold_first succeeds at output empty collection from empty string' {
  # NOTE: stream of empty elements (only end of line)
  run --keep-empty-lines bats_pipe echo '



' \| \
    fold_first as_string ''

  assert_output $'\n'
}

@test 'fold_first succeeds to return only one item for any size input' {
  run --keep-empty-lines bats_pipe echo 'abc

def' \| \
    fold_first as_string ''

  # NOTE: There is an ignored empty element in the middle
  assert_output $'abc def\n'
}

@test 'fold_first succeeds with accumulator functions with arguments' {
  # NOTE: there are both an empty input and a two white space input, empty
  # input is ignored
  run --keep-empty-lines bats_pipe echo 'abc

  
def' \| \
    fold_first as_decorated_string_first '' '<< ' ' >>'

  assert_output $'<< abc >> <<    >> << def >>\n'
}
