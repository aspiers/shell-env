#!/bin/sh

read_localhost_nickname () {
    HOST_NAME_FILE=$HOME/.localhost-nickname
    [ -f "$HOST_NAME_FILE" ] && localhost_nickname="$(<$HOST_NAME_FILE)"
    [ -n "$localhost_nickname" ] && return 0

    echo "Put host nickname in $HOST_NAME_FILE" >&2
    return 1
}
