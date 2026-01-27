setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${FUNCSHIONAL_ROOT_DIR}test/test_helper/bats-support/load"
  load "${FUNCSHIONAL_ROOT_DIR}test/test_helper/bats-assert/load"
}

teardown() {
  :
}

# bats file_tags=bats:focus
@test 'funcshional cannot be used from anywhere in the file system if FUNCSHIONAL_ROOT_DIR is undefined' {
  local funcshional_root_dir &&
    funcshional_root_dir=$FUNCSHIONAL_ROOT_DIR

  unset FUNCSHIONAL_ROOT_DIR

  cd "$BATS_TMPDIR"

  run . "${funcshional_root_dir}"src/funcshional.sh

  assert_not_equal $status 0
}

@test 'funcshional can be used from anywhere in the file system only if FUNCSHIONAL_ROOT_DIR is defined' {
  cd "$BATS_TMPDIR"

  run . "${FUNCSHIONAL_ROOT_DIR}"src/funcshional.sh

  assert_equal $status 0

  load "${FUNCSHIONAL_ROOT_DIR}"src/funcshional.sh

  run [ "$(type -t lift)" = 'function' ]

  assert_equal $status 0
}
