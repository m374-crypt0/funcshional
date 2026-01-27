setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${FUNCSHIONAL_ROOT_DIR}test/test_helper/bats-support/load"
  load "${FUNCSHIONAL_ROOT_DIR}test/test_helper/bats-assert/load"

  load "${FUNCSHIONAL_ROOT_DIR}"src/utility/list.sh
  load "${FUNCSHIONAL_ROOT_DIR}"test/test_functions.sh
}

teardown() {
  :
}

@test 'take fails without an argument' {
  run bats_pipe echo '1
2
3' \| take

  assert_equal $status "$FUNCSHIONAL_MISSING_LIST_INDEX"
}

@test 'take fails without a number as argument' {
  run bats_pipe echo '1
2
3' \| take foo

  assert_equal $status "$FUNCSHIONAL_INVALID_LIST_INDEX"
}

@test 'take fails with a negative number as argument' {
  run bats_pipe echo '1
2
3' \| take -1

  assert_equal $status "$FUNCSHIONAL_INVALID_LIST_INDEX"
}

@test 'take succeeds at returning first elements of a stream' {
  # NOTE: It ignores empty input
  run --keep-empty-lines \
    bats_pipe echo '1
2

3' \| take 3

  assert_output $'1\n2\n3\n'
}

@test 'skip fails without an argument' {
  run bats_pipe echo '1
2
3' \| skip

  assert_equal $status "$FUNCSHIONAL_MISSING_LIST_INDEX"
}

@test 'skip fails without a number as argument' {
  run bats_pipe echo '1
2
3' \| skip foo

  assert_equal $status "$FUNCSHIONAL_INVALID_LIST_INDEX"
}

@test 'skip fails with a negative number as argument' {
  run bats_pipe echo '1
2
3' \| skip -1

  assert_equal $status "$FUNCSHIONAL_INVALID_LIST_INDEX"
}

@test 'skip succeeds at returning last elements of a stream' {
  # NOTE: it ignores empty elements
  run --keep-empty-lines \
    bats_pipe echo '1
2

3
4
5' \| skip 3

  assert_output $'4\n5\n'
}

@test 'prepend succeeds at prepending anything at the top of the stream' {
  run bats_pipe echo 'b
c' \| \
    prepend '0

a'

  assert_output '0

a
b
c'
}

@test 'prepend succeeds at prepending empty item at the top of the stream' {
  run bats_pipe echo 'b
c' \| \
    prepend '
'

  assert_output '

b
c'
}

@test 'append succeeds at appending anything at the top of the stream' {
  run bats_pipe echo 'b
c' \| \
    append '0

a'

  assert_output 'b
c
0

a'
}

@test 'append succeeds at appending empty item at the bottom of the stream' {
  run --keep-empty-lines bats_pipe echo 'b
c' \| \
    append ''

  assert_output $'b\nc\n\n'
}

@test 'any returns error code if stream is empty' {
  run bats_pipe printf '' \| \
    any

  assert_equal $status "$FUNCSHIONAL_ANY_ON_EMPTY_LIST"
}

@test 'any returns 0 if stream is not empty' {
  run bats_pipe echo 'abc
def' \| \
    any

  assert_equal $status 0
  assert_output 'abc
def'
}
