# cron-docker
Cron service on Alpine Docker container

From base image Alpine added `tini bash mariadb-client` packages.
mariadb-client package is used to run remote query on another container who runs MariaDB.
bash installed because I prefer this shell.
tini added because https://github.com/krallin/tini#why-tini

## Running the container
docker run -d --name "my-cron" neomediatech/cron

## Configuration
map a volume where you put your crontab file, for ex:
docker run -d -v /srv/crontab:/var/spool/cron/crontabs --name "my-cron" neomediatech/cron
