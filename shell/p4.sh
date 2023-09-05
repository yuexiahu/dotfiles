#!/bin/bash

this_dir=$(cd "$(dirname "$0")"; pwd)

cp "$this_dir/../res/proxychains4.conf.template" /tmp/proxychains4.conf
sed -i "s/{{proxy_server}}/$proxy_server/g" /tmp/proxychains4.conf

unset ALL_PROXY
unset http_proxy
unset https_proxy

exec proxychains4 -f /tmp/proxychains4.conf "$@"
