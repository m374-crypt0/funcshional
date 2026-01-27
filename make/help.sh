#!/bin/env bash

cat <<EOF
make <TARGET> where <TARGET> in:
- help: print this message
- init: initialize the project, especially dependencies
- test: run all tests
- watch: run all tests continuously, each time a file changed

Do not forget to read the doc (README.md) at the root of this repository.
EOF
