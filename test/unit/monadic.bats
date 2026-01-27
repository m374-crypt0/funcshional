setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${FUNCSHIONAL_ROOT_DIR}test/test_helper/bats-support/load"
  load "${FUNCSHIONAL_ROOT_DIR}test/test_helper/bats-assert/load"

  load "${FUNCSHIONAL_ROOT_DIR}"src/monad/operations.sh
  load "${FUNCSHIONAL_ROOT_DIR}"test/test_functions.sh
}

teardown() {
  :
}

# bats file_tags=bats:focus
@test 'monadic chain start fails if no operation is passed as argument' {
  run m_start

  assert_equal $status "$FUNCSHIONAL_MONAD_START_MISSING_OPERATION"
}

@test 'monadic chain start accept command as argument and execute it' {
  run m_start echo hello

  assert_output hello
}

@test 'monadic chain start accept function call as argument and execute it' {
  run m_start echo_args hello world

  assert_output 'hello world'
}

@test 'monadic chain then cannot be called before a monadic chain start' {
  run m_then

  assert_equal $status "$FUNCSHIONAL_MONAD_INVALID_THEN_CALL"
}

@test 'monadic chain catch cannot be called before a monadic chain start' {
  run m_catch

  assert_equal $status "$FUNCSHIONAL_MONAD_INVALID_CATCH_CALL"
}

@test 'monadic chain end cannot be called before a monadic chain start' {
  run m_end

  assert_equal $status "$FUNCSHIONAL_MONAD_INVALID_END_CALL"
}
