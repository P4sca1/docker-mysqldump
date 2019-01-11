FROM mysql:8.0

RUN apt-get update && \
	apt-get install -y bash cron tar gzip && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /scripts

COPY init.sh init.sh
COPY backup.sh backup.sh

RUN chmod +x init.sh && chmod +x backup.sh

ENV CRON_SCHEDULE="0 4 * * *" MAX_DAYS=7 HOST=localhost PORT=27017

CMD ["/bin/bash", "init.sh"]