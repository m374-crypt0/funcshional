#!/bin/env bash

append_string_to_stream() {
  local stream &&
    stream="$1"

  local line &&
    line="$2"

  if [ -z "$stream" ]; then
    echo "$line"
  else
    echo "$stream"$'\n'"$line"
  fi
}
