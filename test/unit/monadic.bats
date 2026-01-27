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

@test 'lift fails if no operation is passed as argument' {
  run lift

  assert_equal $status "$FUNCSHIONAL_MONAD_LIFT_MISSING_OPERATION"
}

@test 'unlift cannot be called before a lift' {
  run unlift echo hey

  assert_equal $status "$FUNCSHIONAL_MONAD_INVALID_UNLIFT_CALL"
}

@test 'unlift fails if no operation is passed as argument' {
  run bats_pipe lift echo hey \| \
    unlift

  assert_equal $status "$FUNCSHIONAL_MONAD_UNLIFT_MISSING_OPERATION"
}

@test 'and_then cannot be called before a lift' {
  run and_then

  assert_equal $status "$FUNCSHIONAL_MONAD_INVALID_AND_THEN_CALL"
}

@test 'and_then cannot be called without an operation' {
  run bats_pipe lift true \| \
    and_then

  assert_equal $status "$FUNCSHIONAL_MONAD_AND_THEN_MISSING_OPERATION"
}

@test 'or_else cannot be called before a lift' {
  run or_else

  assert_equal $status "$FUNCSHIONAL_MONAD_INVALID_OR_ELSE_CALL"
}

@test 'or_else cannot be called without an operation' {
  run bats_pipe lift true \| \
    or_else

  assert_equal $status "$FUNCSHIONAL_MONAD_OR_ELSE_MISSING_OPERATION"
}

@test 'lift accepts command as argument executes it and lifts its output' {
  run bats_pipe lift echo hello \| \
    unlift echo world

  # assert_equal $status 0
  assert_output 'hello
world'
}

@test 'lift accepts function call as argument executes it and lifts its output' {
  run bats_pipe lift echo_args hello world \| \
    unlift echo '!'

  assert_equal $status 0
  assert_output 'hello world
!'
}

@test 'failed command in and_then propagates error in unlift' {
  run bats_pipe lift report_success \| \
    and_then report_failure \| \
    unlift echo propagated error

  assert_not_equal $status 0
  assert_output 'succeeded
failed
propagated error'
}

@test 'lift succeeds command execution for and_then further processing' {
  run bats_pipe lift report_success \| \
    and_then echo that is good \| \
    and_then echo that is so cool \| \
    unlift echo successful ending

  assert_equal $status 0
  assert_output 'succeeded
that is good
that is so cool
successful ending'
}

@test 'lift successful command execution, ignore or_else calls' {
  run bats_pipe lift report_success \| \
    or_else report_failure \| \
    and_then echo_args or_else ignored \| \
    or_else report_failure \| \
    unlift echo .

  assert_equal $status 0
  assert_output 'succeeded
or_else ignored
.'
}

@test 'lift fails command execution for or_else further processing' {
  run bats_pipe lift report_failure \| \
    or_else report_failure \| \
    unlift echo chain of failure

  assert_not_equal $status 0
  assert_output 'failed
failed
chain of failure'
}

@test 'lift fails command execution, ignore and_then calls' {
  run bats_pipe lift report_failure \| \
    and_then report_success \| \
    or_else report_failure \| \
    and_then report_success \| \
    unlift echo chain of failure

  assert_not_equal $status 0
  assert_output 'failed
failed
chain of failure'
}

@test 'or_else can break error chain for further processing by and_then' {
  run bats_pipe lift report_failure \| \
    or_else echo succeeding command after a fail \| \
    and_then report_success \| \
    unlift echo chain of success

  assert_equal $status 0
  assert_output 'failed
succeeding command after a fail
succeeded
chain of success'
}
