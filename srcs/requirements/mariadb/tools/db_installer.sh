#!/bin/sh

# Assign the ownership of the directory to the MySQL user and group
chown -R mysql:mysql /var/lib/mysql

# Replace the port in the MySQL configuration file
sed -i "s/REPLACE_MYSQL_PORT/$DB_PORT/g" /etc/mysql/my.cnf

# Initialize MySQL database
mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

# Start MySQL in the background
/usr/bin/mysqld_safe --datadir=/var/lib/mysql &

# Wait until the MySQL server is available
while ! /usr/bin/mysqladmin ping --silent; do
	sleep 1
done

# Cleaning the database
mysql -u root -e "DROP DATABASE IF EXISTS test;"
mysql -u root -e "DELETE FROM mysql.user WHERE User='';"
mysql -u root -e "DELETE FROM mysql.db WHERE Db='test';"

# Inserting the data into the database
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $WP_DB_NAME;"
mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u root -e "GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$DB_USER'@'%' WITH GRANT OPTION;"
mysql -u root -e "FLUSH PRIVILEGES;"

# Shutdown MySQL in the background
mysqladmin shutdown

# Start MySQL in the foreground
/usr/bin/mysqld_safe --datadir=/var/lib/mysql