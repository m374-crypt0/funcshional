setup() {
  load "${ROOT_DIR}test/test_helper/bats-support/load"
  load "${ROOT_DIR}test/test_helper/bats-assert/load"

  load "${ROOT_DIR}"src/funcshional.sh
  load "${ROOT_DIR}"test/test_functions.sh
}

teardown() {
  :
}

@test 'fold_first fails if not passed with an accumulator function' {
  run bats_pipe echo \| \
    fold_first unexisting_function

  assert_equal $status 1
}

@test 'fold_first fails if not passed an initial accumulator value' {
  run bats_pipe echo \| \
    fold_first as_string

  assert_equal $status 1
}

@test 'fold_first succeeds at output empty collection from empty string' {
  run bats_pipe echo \| \
    fold_first as_string ''

  assert_output ''
}

@test 'fold_first succeeds to return only one item for any size input' {
  run bats_pipe echo 'abc

def' \| \
    fold_first as_string ''

  assert_output 'abc def'
}
