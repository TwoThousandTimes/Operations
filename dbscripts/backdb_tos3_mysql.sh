#!/bin/bash +x

echo "*********************"
echo "* Backup up current db to S3"
echo "*********************"
date --iso=seconds

echo "running as user $USER"
#to snapshot db to s3

DB=twothousand
USR=twothousand
PWD='TT99**'
S3BUCKET=s3://TTTservers/DB-backups/$HOSTNAME

echo "DB: $USR@$DB"

set -v

current_time=$(date "+%Y.%m.%d-%H.%M.%S")
file=mysqldump-$DB-$current_time.sql

mysqldump -u "$USR" -p"$PWD" $DB > /tmp/$file
aws s3 cp /tmp/$file $S3BUCKET/$file

rm -f /tmp/$file

set +xv
echo
echo "done..."
date --iso=seconds
echo "***********************"
echo
