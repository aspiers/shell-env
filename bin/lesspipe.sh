#!/bin/sh
#
# To use this filter with less, define LESSOPEN:
# export LESSOPEN="|/path/to/lesspipe.sh %s"

lesspipe() {
  case "$1" in
      *.rpm)
          rpm -qpivl --changelog --scripts --triggers -- "$1" ;;
      *)
          /usr/bin/lesspipe.sh "$@" ;;
  esac
}

lesspipe "$1" 2> /dev/null
