setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${ROOT_DIR}test/test_helper/bats-support/load"
  load "${ROOT_DIR}test/test_helper/bats-assert/load"

  load "${ROOT_DIR}"src/funcshional.sh
  load "${ROOT_DIR}"test/test_functions.sh
}

teardown() {
  :
}

@test 'partition_first fails if first argument is not a function' {
  run bats_pipe echo '' \| \
    partition_first unexisting_function

  assert_equal $status 1
}

@test 'partition_first return an empty stream if input stream is empty' {
  run bats_pipe echo '' \| \
    partition_first non_empty

  assert_equal $status 0
  assert_output ''
}

@test 'partition_first succeeds with argumentless predicate' {
  run --keep-empty-lines bats_pipe echo 'a
b
c

d
e
f' \| \
    partition_first non_empty

  assert_output $'6\na\nb\nc\nd\ne\nf\n\n'
}
