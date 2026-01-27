function run_tests(){
  # shellcheck source=/dev/null
  . "${ROOT_DIR}"make/test.sh
}

run_tests

inotifywait -mqr \
  --event modify \
  "${ROOT_DIR}"test \
  "${ROOT_DIR}"src \
| while read -r; do
  clear && run_tests
done
