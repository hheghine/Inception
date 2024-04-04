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
	@mkdir -p ~/data/wordpress
#	@mkdir -p ~/data/uptime-kuma

#check-hosts:

start: init
	@docker-compose -f ./srcs/docker-compose.yml up -d --build
	@printf "${CLEAR}${RESET}${GREY}─────────────────────────────────────────────────────\n"\
	"${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: ${NAME} has cooked with ${GREEN}success${RESET}.${GREY}\n"\
	"${RESET}${GREY}─────────────────────────────────────────────────────\n${RESET}"
	@make -s status

stop:
ifneq ($(CONTAINERS),)
	@docker-compose -f ./srcs/docker-compose.yml stop
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: Containers stopped ${GREEN}successfully${RESET}.\n"
else
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: There's ${RED}nothing ${RESET}to stop.\n${RESET}"
endif

down:
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: Dropping containers... ${GREEN}successfully${RESET}.\n"
	@docker-compose -f ./srcs/docker-compose.yml down
	@printf "${CLEAR}${RESET}${GREEN}Done!{RESET}.\n"

hard_down:
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: Dropping containers and removing volumes... ${GREEN}successfully${RESET}.\n"
	@docker-compose -f ./srcs/docker-compose.yml down -v
	@printf "${CLEAR}${RESET}${GREEN}Done!{RESET}.\n"

status:
ifneq ($(CONTAINERS),)
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: ${}Displaying containers ${PURPLE}status${RESET}...\n\n${RESET}"
	@docker ps -a
else
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: There's ${RED}nothing ${RESET}to display.\n\n${RESET}"
endif

rm:
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: Removing stopped service containers... ${GREEN}successfully${RESET}.\n"
	@docker-compose -f ./srcs/docker-compose.yml rm
	@printf "${CLEAR}${RESET}${GREEN}Done!{RESET}.\n"

clean:
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: Cleaning docker containers... ${GREEN}successfully${RESET}.\n"
	@docker kill $(docker ps -q) 2> /dev/null || true
	@docker rm $(docker ps -aq) 2> /dev/null || true
	@printf "${CLEAR}${RESET}${GREEN}Done!${RESET}.\n"

fclean: clean
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: Cleaning all docker images, networks, containers... ${GREEN}successfully${RESET}.\n"
	@docker system prune -a
	@printf "${CLEAR}${RESET}${GREEN}Done!${RESET}.\n"

.PHONY: all start init stop status clean fclean