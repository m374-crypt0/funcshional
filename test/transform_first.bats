set -o pipefail

setup() {
  load "${ROOT_DIR}test/test_helper/bats-support/load"
  load "${ROOT_DIR}test/test_helper/bats-assert/load"

  load "${ROOT_DIR}"src/funcshional.sh
  load "${ROOT_DIR}"test/test_functions.sh
}

teardown() {
  :
}

@test 'transform_first output nothing for empty input' {
  run bats_pipe echo \| \
    transform_first to_foo

  assert_output ''
}

@test 'transform_first fails if not provided a function to transform input' {
  run bats_pipe echo abc \| \
    transform_first

  assert_equal $status 1
}

@test 'transform_first succeeds and output as much as foo there is textual entries for argumentless transformer' {
  run bats_pipe echo 'abc
def
ghi' \| \
    transform_first to_foo

  assert_output 'foo
foo
foo'
}

@test 'transform_first fails if first argument is not a function' {
  run bats_pipe echo 'abc
def
ghi' \| \
    transform_first inexisting_function

  assert_equal $status 1
}
