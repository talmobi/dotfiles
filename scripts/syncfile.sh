#!/bin/bash

EXECUTE=0
VERBOSITY=0

function log {
  if [[ $VERBOSITY -ge 1 ]]; then
    echo "$@"
  fi
}

while getopts "xvp:r:f:t:" opt; do
  case $opt in
    x)
      EXECUTE=1
      ;;
    v)
      VERBOSITY=$((1 + VERBOSITY))
      ;;
    p)
      PASSWORD="$OPTARG"
      ;;
    r)
      RELATIVE="$OPTARG"
      ;;
    f)
      FILE="$OPTARG"
      ;;
    t)
      TARGET="$OPTARG"
      ;;
    :)
      echo "Missing option argument." >&2
      exit 1
      ;;
    \?)
      echo "Unknown option." >&2
      exit 1
      ;;
  esac
done

log "password: $PASSWORD"
log "relative: $RELATIVE"

log "execute: $EXECUTE"
log "verbosity: $VERBOSITY"

if [ -z "$FILE" ]; then
  log "No file specified: $FILE"
  exit 1
else
  log "file: $FILE"
fi

log "target: $TARGET"

if [ -z "$RELATIVE" ]; then
  DEST=$FILE
else
  log "Transforming filename relative to $RELATIVE"
  DEST="${FILE#$RELATIVE}"
fi

if [ -z "$TARGET" ]; then
  # do nothing
  log "no target specified"
else
  DEST="$TARGET$DEST"
fi

log "DEST: $DEST"

COMMAND="scp $FILE $DEST"

if [ -z "$PASSWORD" ]; then
  log "no -p password set"
else
  log "adding -p password with sshpass"
  COMMAND="sshpass -p '$PASSWORD' $COMMAND"
fi

log "command: $COMMAND"

if [ $EXECUTE -eq 0 ]; then
  if [[ $VERBOSITY -eq 0 ]]; then
    echo "$COMMAND"
  fi
  echo
  echo "no -x argument found. exiting without executing"
  exit 0
else
  eval $COMMAND
fi

if [ $? -eq 0 ]; then
  log 'success'
  exit 0
else
  log 'fail'
  exit 1
fi
