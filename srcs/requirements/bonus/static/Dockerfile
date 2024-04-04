FROM alpine:3.17

RUN apk update \
	&& apk add --no-cache nodejs npm git

RUN mkdir -p /app

WORKDIR /app

COPY ./config/server.js /app/server.js
COPY ./config/public /app/public
COPY ./tools/ws_installer.sh /tmp/ws_installer.sh

EXPOSE 4242

CMD ["/bin/sh", "/tmp/ws_installer.sh"]