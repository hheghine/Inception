#!/bin/sh

# Replacing ports from env
sed -i "s/REPLACE_SW_PORT/$SW_PORT/g" /etc/nginx/nginx.conf
sed -i "s/REPLACE_ADM_PORT/$ADM_PORT/g" /etc/nginx/nginx.conf
sed -i "s/REPLACE_WP_PORT/$WP_PORT/g" /etc/nginx/nginx.conf

# Start Nginx in the foreground
nginx -g "daemon off;"