#!/bin/bash

# workaround for env variables not being available for cron.
CRON_ENV="MAX_DAYS='$MAX_DAYS'\nHOST='$HOST'\nPORT='$PORT'\nUSERNAME='$USERNAME'\nPASSWORD='$PASSWORD'\nPASSWORD_FILE='$PASSWORD_FILE'"

echo -e "$CRON_ENV\n$CRON_SCHEDULE /bin/bash /scripts/backup.sh >> /proc/1/fd/1 2>&1 \n" | crontab -

cron -f