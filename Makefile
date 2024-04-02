#!/bin/bash

# color constants
PURPLE			= \033[38;5;141m
GREEN			= \033[38;5;46m
RED				= \033[0;31m
YELLOW			= \033[0;33m
GREY			= \033[38;5;240m
RESET			= \033[0m
BOLD			= \033[1m
CLEAR			= \r\033[K

# variables
NAME			= inception
CONTAINERS		= $(shell docker ps -a -q)
VOLUMES			= $(shell docker volume ls -q)
#HOSTS
#EXPECTED

# rules
all: start

init:
	@mkdir -p ~/data/mariadb
#	@mkdir -p ~/data/wordpress
#	@mkdir -p ~/data/uptime-kuma

#check-hosts:

start:
	@docker-compose -f ./srcs/docker-compose.yml up -d --build
	@printf "${CLEAR}${RESET}${GREY}─────────────────────────────────────────────────────\n"\
	"${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: ${NAME} has cooked with ${GREEN}success${RESET}.${GREY}\n"\
	"${RESET}${GREY}─────────────────────────────────────────────────────\n${RESET}"
	@make -s status

stop:
ifneq ($(CONTAINERS),)
	@docker-compose -f ./srcs/docker-compose.yml down
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: Containers stopped ${GREEN}successfully${RESET}.\n"
else
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: There's ${RED}nothing ${RESET}to stop.\n${RESET}"
endif

status:
ifneq ($(CONTAINERS),)
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: ${}Displaying containers ${PURPLE}status${RESET}...\n${RESET}"
	@docker ps -a
else
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: There's ${RED}nothing ${RESET}to display.\n${RESET}"
endif

clean: stop

fclean: clean
		@rm -rf ~/data

.PHONY: all start stop status clean fclean