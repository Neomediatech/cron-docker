FROM alpine:3.10

ENV VERSION=1.0.0-r1 \ 
    BUILD_DATE=2019-10-11 \ 
    TZ=Europe/Rome

LABEL maintainer="docker-dario@neomediatech.it" \ 
      org.label-schema.version=$VERSION \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-type=Git \
      org.label-schema.vcs-url=https://github.com/Neomediatech/cron-docker \
      org.label-schema.maintainer=Neomediatech

RUN apk update && apk upgrade && apk add --no-cache tzdata && cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    apk add --no-cache tini bash mariadb-client && \ 
    rm -rf /usr/local/share/doc /usr/local/share/man /var/cache/apk/* && \ 
    rm -f /var/spool/cron/crontabs && \ 
    mkdir /var/spool/cron/crontabs && \
    [ ! -f /var/spool/cron/crontabs/root ] && echo "# min	hour	day	month	weekday	command " > /var/spool/cron/crontabs/root

ENTRYPOINT ["tini", "--"]
CMD ["crond", "-f", "-d", "8"]
