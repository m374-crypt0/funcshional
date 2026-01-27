#!/bin/env bash

set -o pipefail

# shellcheck source=./internals_.sh
. "${ROOT_DIR}"src/internals_.sh

# shellcheck source=./hof/transform.sh
. "${ROOT_DIR}"src/hof/transform.sh

# shellcheck source=./hof/fold.sh
. "${ROOT_DIR}"src/hof/fold.sh

# shellcheck source=./hof/filter.sh
. "${ROOT_DIR}"src/hof/filter.sh

# shellcheck source=./hof/partition.sh
. "${ROOT_DIR}"src/hof/partition.sh

# shellcheck source=./utility/list.sh
. "${ROOT_DIR}"src/utility/list.sh
