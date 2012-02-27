#!/bin/bash

fatal ()
{
    error "$@"
}

# Broken out as special case for log() failure.  Ordinarily you
# should just use error() to terminate.
_die ()
{
    echo "ERROR: $@" >&2
    exit 1
}

error ()
{
    log "ERROR: $@"
    _die "$@"
}

warn ()
{
    log "WARNING: $@"
    echo "WARNING: $@" >&2
}

log ()
{
    if [ -z "$LOG_FILE" ]; then
        #_die "\$LOG_FILE was not set - aborting"
        return
    fi
    echo "$*" >> "$LOG_FILE" || _die "Can't append to $LOG_FILE - aborting"
}
