#!/usr/bin/env bash

# ensure we only print a message once
FIRST_RUN_FILE=/tmp/bats-tutorial-project-ran

if [[ ! -e "$FIRST_RUN_FILE" ]]; then
    echo "Welcome to our project!"
    touch "$FIRST_RUN_FILE"
fi

case $1 in
    start-echo-server)
        echo "Starting echo server"
        PORT=2000
        ncat -l $PORT -k -c 'xargs -n1 echo' 2>/dev/null & # don't keep open this script's stderr
        echo $! > /tmp/project-echo-server.pid
        echo "$PORT" >&2
    ;;
    stop-echo-server)
        kill "$(< "/tmp/project-echo-server.pid")"
        rm /tmp/project-echo-server.pid
    ;;
    *)
        echo "NOT IMPLEMENTED!" >&2
        exit 1
    ;;
esac

