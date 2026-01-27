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
    fold_first

  assert_equal $status 1
}
