#!/bin/bash

# color constants
PURPLE			= \033[38;5;141m
GREEN			= \033[38;5;46m
RED				= \033[0;31m
GREY			= \033[38;5;240m
RESET			= \033[0m
BOLD			= \033[1m
CLEAR			= \r\033[K

# variables
NAME			= inception
#CONTAINERS
#VOLUMES
#HOSTS
#EXPECTED

# rules
all: start

init:
	@mkdir -p ~/data/wordpress
	@mkdir -p ~/data/uptime-kuma
	@mkdir -p ~/data/mariadb

#check-hosts:

#start:

#stop:

#status:

#clean: stop

fclean: clean
			@rm -rf ~/data

.PHONY: all start stop status clean fclean