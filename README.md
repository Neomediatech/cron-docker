Cron service on Alpine Docker container

From base image Alpine added `tini bash mariadb-client` packages.  
mariadb-client package is used to run remote query on another container who runs MariaDB.  
bash installed because I prefer this shell.  
tini added because https://github.com/krallin/tini#why-tini  

## Running the container
`docker run -d --name "my-cron" neomediatech/cron`  

## Configuration
Map a volume where you put your crontab file, for ex:  
`docker run -d -v /srv/crontab:/var/spool/cron/crontabs --name "my-cron" neomediatech/cron`  

## Reload cron service
No need to reload the service. If you made changes on /var/spool/cron/crontabs/root you can notify it to cron service running this command:  
`docker exec my-cron bash -c 'echo "root" > /var/spool/cron/crontabs/cron.update'`.  
Wait a minute (really) and cron will get the changes.  

## Running your own scripts
Map a volume where you put your own scripts, for ex:  
`docker run -d -v /srv/crontab:/var/spool/cron/crontabs -v /srv/my-scripts:/scripts --name "my-cron" neomediatech/cron`.  
Afterwards put a line on /var/spool/cron/crontabs/root to execute the script wen you want, for ex:  
`docker exec my-cron bash -c 'echo "0 5 * * * /scripts/my-script.sh" >> /var/spool/cron/crontabs/root'`  
and then  
`docker exec my-cron bash -c 'echo "root" > /var/spool/cron/crontabs/cron.update'`  

## Logs
Cron logs output visible on docker logs (`docker logs my-cron`)  

## Stack
[docker-compose.yml](docker-compose.yml) contains an example
