#!/bin/sh

if [ "$1" = "test" ]
then
    exec cloudflared proxy-dns &
    sleep 10 && drill -p 5053 cloudflare.com @127.0.0.1 || exit 1
else
    echo "cloudflared $@"
    exec cloudflared $@
fi