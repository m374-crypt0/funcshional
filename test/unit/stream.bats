setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${FUNCSHIONAL_ROOT_DIR}test/test_helper/bats-support/load"
  load "${FUNCSHIONAL_ROOT_DIR}test/test_helper/bats-assert/load"

  load "${FUNCSHIONAL_ROOT_DIR}"src/utility/stream.sh
  load "${FUNCSHIONAL_ROOT_DIR}"test/test_functions.sh
}

teardown() {
  :
}

@test 'attempting to generate a stream without specifying a size fails' {
  run generate

  assert_equal $status "$FUNCSHIONAL_STREAMS_GENERATE_INVALID_CALL"
}

@test 'generate fails if first argument is not a number' {
  run generate foo

  assert_equal $status "$FUNCSHIONAL_STREAMS_GENERATE_INVALID_SIZE"
}

@test 'generate need a generator expression function' {
  run generate 3

  assert_equal $status "$FUNCSHIONAL_STREAMS_GENERATE_INVALID_GENERATOR"
}

@test 'There is a default index generator function' {
  run generate 3 index

  assert_equal $status 0
  assert_output $'0\n1\n2'
}
