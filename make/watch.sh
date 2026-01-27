function run_tests() {
  # shellcheck source=/dev/null
  . "${FUNCSHIONAL_ROOT_DIR}"make/test.sh
}

run_tests

inotifywait -mqr \
  --event modify \
  "${FUNCSHIONAL_ROOT_DIR}"test \
  "${FUNCSHIONAL_ROOT_DIR}"src |
  while read -r; do
    clear && run_tests
  done
