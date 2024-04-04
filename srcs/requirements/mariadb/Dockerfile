FROM alpine:3.16

# Update and install packages
RUN apk update \
	&& apk add --no-cache \
		mariadb \
		mariadb-client

# Copy files
COPY ./tools/db_installer.sh /tmp/db_installer.sh
COPY ./config/my.cnf /etc/mysql/my.cnf
RUN chmod +x /tmp/db_installer.sh

# Expose ports
EXPOSE 3306

# Run script
CMD ["sh", "/tmp/db_installer.sh"]