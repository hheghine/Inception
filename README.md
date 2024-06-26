# 🐳 Inception

<p align="center">
	<b><i>Inception is a project from the 42 School that aims to broaden the knowledge of system administration by using Docker.</i></b><br><br>
</p>

![docker](https://github.com/hheghine/Inception/assets/119530584/ed364958-961e-40f7-b442-4771b149bda5)

## Introduction

The goal of the project is to containerize a simple web application infrastructure using Docker Compose.

The project involves setting up three mandatory containers - a `MariaDB` database, an `NGINX` web server, and a `WordPress` instance and several optional bonus services as an additional challenge:

- `Redis` - Caching service for WordPress to improve performance
- `FTP Server` - To enable file transfers to the WordPress container
- `Static Website` - A simple HTML/CSS site running behind a NodeJS container
- `Adminer` - Database management tool for MariaDB
- `Uptime Kuma` - Container monitoring solution to track services
