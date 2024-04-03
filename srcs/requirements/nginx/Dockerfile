FROM alpine:3.17

# Updating and installing dependencies
RUN apk update \
 && apk add --no-cache nginx openssl

# Creating needed directories
RUN mkdir -p /run/nginx /etc/nginx/ssl /var/www/html /tmp

# Creating our certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/hbalasan-selfsigned.key \
	-out /etc/nginx/ssl/hbalasan-selfsigned.crt \
	-subj "/C=AM/ST=Yerevan/L=Yerevan/O=42/OU=hbalasan/CN=hbalasan.42.fr"

# Modifying permissions to be sure
RUN chmod -R 755 /var/www/html

# Copying our configuration
COPY ./config/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/index.html /var/www/html/index.html
COPY ./tools/var_handler.sh /tmp/var_handler.sh

# Handling port replacement
RUN chmod +x /tmp/var_handler.sh

# Allowing needed port
EXPOSE 443

# Running NGINX in background
CMD ["sh", "/tmp/var_handler.sh"]