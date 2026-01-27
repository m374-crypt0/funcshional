#!/bin/env bash

set -o pipefail

# shellcheck source=../internals_.sh
. "${FUNCSHIONAL_ROOT_DIR}"src/internals_.sh

# shellcheck source=../error_codes.sh
. "${FUNCSHIONAL_ROOT_DIR}"src/error_codes.sh

m_start() {
  if [ -z "$*" ]; then
    return $FUNCSHIONAL_MONAD_START_MISSING_OPERATION
  fi

  eval "$*"
}

m_then() {
  return $FUNCSHIONAL_MONAD_INVALID_THEN_CALL
}

m_catch() {
  return $FUNCSHIONAL_MONAD_INVALID_CATCH_CALL
}

m_end() {
  return $FUNCSHIONAL_MONAD_INVALID_END_CALL
}
