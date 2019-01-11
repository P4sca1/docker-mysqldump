#!/bin/bash

if [ ! -z "$PASSWORD_FILE" ]; then
	if [ ! -f "$PASSWORD_FILE" ]; then
		>&2 echo "Invalid path for PASSWORD_FILE (file not found)."
		exit 1
	else
		PASSWORD="$(cat $PASSWORD_FILE)"
	fi
fi

echo "Removing old backups..."
find /backup -maxdepth 1 -type f -ctime +${MAX_DAYS} -exec rm {} \;

echo "Dumping all databases..."

NOW=$(date +%Y-%m-%d_%H-%M)

mysqldump --all-databases --host=$HOST --port=$PORT --user=$USERNAME --password=$PASSWORD --extended-insert > $NOW.sql

chmod 700 $NOW.sql
gzip $NOW.sql
cp $NOW.sql.gz /backup/$NOW.sql.gz
rm -f $NOW.sql.gz

echo "Backup finished!"