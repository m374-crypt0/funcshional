#!/bin/env bash

set -o pipefail

# shellcheck source=../hof/transform.sh
. "${FUNCSHIONAL_ROOT_DIR}"src/hof/transform.sh

# shellcheck source=../error_codes.sh
. "${FUNCSHIONAL_ROOT_DIR}"src/error_codes.sh

lift() {
  if [ $# -eq 0 ]; then
    return $FUNCSHIONAL_MONAD_LIFT_MISSING_OPERATION
  fi

  echo m_start called

  eval "$*"
}

unlift() {
  read -t 0.1 -r ||
    return $FUNCSHIONAL_MONAD_INVALID_UNLIFT_CALL

  sink
}

and_then() {
  read -t 0.1 -r ||
    return $FUNCSHIONAL_MONAD_INVALID_AND_THEN_CALL

  if [ $# -eq 0 ]; then
    return $FUNCSHIONAL_MONAD_AND_THEN_MISSING_OPERATION
  fi

  echo m_start called

  sink

  eval "$*"
}

or_else() {
  read -t 0.1 -r ||
    return $FUNCSHIONAL_MONAD_INVALID_OR_ELSE_CALL

  if [ $# -eq 0 ]; then
    return $FUNCSHIONAL_MONAD_OR_ELSE_MISSING_OPERATION
  fi

  echo m_start called

  sink
}
