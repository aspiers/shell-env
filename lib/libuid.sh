#!/bin/sh

ensure_uid_root () {
  if [ `id -u` != 0 ]; then
    echo "Not root; aborting." >&2
    exit 1
  fi
}

ensure_uid_non_root () {
  if [ `id -u` = 0 ]; then
    echo "Must not be root; aborting." >&2
    exit 1
  fi
}
