setup() {
  load "${ROOT_DIR}test/test_helper/bats-support/load"
  load "${ROOT_DIR}test/test_helper/bats-assert/load"

  load "${ROOT_DIR}"src/funcshional.sh
  load "${ROOT_DIR}"test/test_functions.sh
}

teardown() {
  :
}

@test 'fold_last fails if not passed with an accumulator function' {
  run bats_pipe echo \| \
    fold_last unexisting_function

  assert_equal $status 1
}

@test 'fold_last fails if not passed an initial accumulator value' {
  run bats_pipe echo \| \
    fold_last as_string

  assert_equal $status 1
}

@test 'fold_last succeeds at output empty collection from empty string' {
  run bats_pipe echo \| \
    fold_last as_string ''

  assert_output ''
}

@test 'fold_last succeeds to return only one item for any size input' {
  run bats_pipe echo 'abc

def' \| \
    fold_last as_string ''

  # NOTE: There an empty element in the middle, hence two spaces between abc
  # and def
  assert_output 'abc  def'
}

@test 'fold_last succeeds with accumulator functions with arguments' {
  # NOTE: there are both an empty input and a two white space input
  run bats_pipe echo 'abc

  
def' \| \
    fold_last as_decorated_string_last '' '<< ' ' >>'

  assert_output '<< abc >> <<  >> <<    >> << def >>'
}
