#!/bin/sh

nohup sh -c '/usr/local/bin/cloudflared proxy-dns' &

sleep 5

dig @127.0.0.1 -p 5053 cloudflare.com A || exit 1