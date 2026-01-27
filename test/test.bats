setup_file(){
  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'

  # shellcheck source=/dev/null
   . "${ROOT_DIR}"src/funcshional.sh
}

teardown_file(){
  :
}

@test '' {
  :
}
