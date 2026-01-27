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

@test 'take fails without an argument' {
  run bats_pipe echo '1
2
3' \| take

  assert_equal $status 1
}

@test 'take fails without a number as argument' {
  run bats_pipe echo '1
2
3' \| take foo

  assert_equal $status 1
}

@test 'take fails with a negative number as argument' {
  run bats_pipe echo '1
2
3' \| take -1

  assert_equal $status 1
}

@test 'take succeeds at returning first elements of a stream' {
  run --keep-empty-lines \
    bats_pipe echo '1
2

3' \| take 3

  assert_output $'1\n2\n\n'
}

@test 'skip fails without an argument' {
  run bats_pipe echo '1
2
3' \| skip

  assert_equal $status 1
}

@test 'skip fails without a number as argument' {
  run bats_pipe echo '1
2
3' \| skip foo

  assert_equal $status 1
}

@test 'skip fails with a negative number as argument' {
  run bats_pipe echo '1
2
3' \| skip -1

  assert_equal $status 1
}

@test 'skip succeeds at returning last elements of a stream' {
  run --keep-empty-lines \
    bats_pipe echo '1
2

3
4
5' \| skip 3

  assert_output $'3\n4\n5\n'
}

@test 'prepend succeeds at preprending anything at the top of the stream' {
  run bats_pipe echo 'b
c' \| \
    prepend '0

a'

  assert_output '0

a
b
c'
}
