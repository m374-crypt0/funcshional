setup() {
  load "${ROOT_DIR}test/test_helper/bats-support/load"
  load "${ROOT_DIR}test/test_helper/bats-assert/load"

  load "${ROOT_DIR}"src/funcshional.sh
  load "${ROOT_DIR}"test/test_functions.sh
}

teardown() {
  :
}

@test 'transform_last output nothing for empty input' {
  # NOTE: printf does not issue an end of line, that is the natural delimiter
  # of stream
  run bats_pipe printf '' \| \
    transform_last to_foo

  assert_output ''
}

@test 'transform_last fails if not provided a function to transform input' {
  run bats_pipe echo abc \| \
    transform_last

  assert_equal $status 1
}

@test 'transform_last fails if transformer function fails' {
  run bats_pipe echo abc \| \
    transform_last failing_transformer

  assert_equal $status 1
}

@test 'transform_last succeeds and output as much as foo there is textual entries for argumentless transformer' {
  run bats_pipe echo 'abc
def
ghi' \| \
    transform_last to_foo

  assert_output 'foo
foo
foo'
}

@test 'transform_last fails if first argument is not a function' {
  run bats_pipe echo 'abc
def
ghi' \| \
    transform_last inexisting_function

  assert_equal $status 1
}

@test 'transform_last succeeds at using a transformer whose last arg is stream item' {
  run bats_pipe echo 'abc
def
ghi' \| \
    transform_last t_last_append xyz '' qwe

  assert_output 'abcxyzqwe
defxyzqwe
ghixyzqwe'
}

@test 'transform_last succeeds at using a transformer whose last arg is stream item and white spaces' {
  run bats_pipe echo 'abc
def
ghi' \| \
    transform_last t_last_append xyz '  ' qwe

  assert_output 'abcxyz  qwe
defxyz  qwe
ghixyz  qwe'
}

@test 'transform_last takes also white spaces line only into account' {
  # NOTE: first line is composed of 2 white spaces, second one, only end of
  # line
  run bats_pipe echo '  

bar' \| \
    transform_last to_foo

  assert_output 'foo
foo
foo'
}
