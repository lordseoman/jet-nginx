#!/bin/bash

sleep infinity & PID=$!
trap "kill $PID" INT TERM

if [ -e /var/run/nginx.pid ]; then
    echo "Stale pid file."
    rm /var/run/nginx.pid
fi

if [! -e /opt/nginx/log ]; then
    echo "Creating log directory."
    mkdir /opt/nginx/log
fi

if [! -e /opt/nginx/rules.d ]; then
    echo "Creating NGinX rules directory."
    mkdir /opt/nginx/rules.d
fi

echo "args: $@"

echo "Starting nginx..."
exec $(which nginx) -c /etc/nginx/nginx.conf -g "daemon off;"

wait
echo "Goodbye.."
