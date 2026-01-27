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

@test 'partition_last fails if first argument is not a function' {
  run bats_pipe echo a \| \
    partition_last unexisting_function

  assert_equal $status 1
}

@test 'partition_last returns nothing if input stream contains only empty elements' {
  run bats_pipe echo '



' \| \
    partition_last only_letter

  assert_output ''
}

@test 'partition_last perform partitioning for all items' {
  run bats_pipe echo 'a
b' \| \
    partition_last only_letter

  assert_output $'2\na\nb'
}

@test 'partition_last ignores empty input in the stream' {
  run --keep-empty-lines bats_pipe echo 'a

b' \| \
    partition_last only_letter

  assert_output $'2\na\nb\n'
}

@test 'partition_last output filtered out item at the bottom' {
  run bats_pipe echo '1
b' \| \
    partition_last only_letter

  assert_output $'1\nb\n1'
}

@test 'partition_last output filtered out item at the bottom ignoring empty inputs' {
  run --keep-empty-lines bats_pipe echo '1
b

3

c
a

2' \| \
    partition_last only_letter

  assert_output $'3\nb\nc\na\n1\n3\n2\n'
}

@test 'partition_last succeeds in partitioning using a predicate using arguments' {
  run --keep-empty-lines bats_pipe echo '1
b

3

c
a

2' \| \
    partition_last only_last a b c

  assert_output $'3\nb\nc\na\n1\n3\n2\n'
}
