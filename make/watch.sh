function run_tests() {
  # shellcheck source=/dev/null
  . "${ROOT_DIR}"make/test.sh
}

run_tests

while true; do
  inotifywait -mqr \
    --event modify \
    "${ROOT_DIR}"test \
    "${ROOT_DIR}"src |
    run_tests
done
