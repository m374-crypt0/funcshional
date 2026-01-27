#!/bin/env bash

init_bats() {
  git submodule update --init --recursive
}

main() {
  init_bats
}

main
