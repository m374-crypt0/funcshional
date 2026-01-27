setup(){
  load "${ROOT_DIR}test/test_helper/bats-support/load"
  load "${ROOT_DIR}test/test_helper/bats-assert/load"

  load "${ROOT_DIR}"src/funcshional.sh
  load "${ROOT_DIR}"test/test_functions.sh
}

teardown(){
  :
}

@test 'transform_first output nothing for empty input' {
  run bats_pipe echo \| \
    transform_first to_foo

  assert_output ''
}
