#!/bin/bash +x

echo "*********************"
echo "* Backup up current db to S3"
echo "*********************"
date --iso=seconds

echo "running as user $USER"
#to snapshot db to s3

DB=database
USR=twothousand
PWD='TT99!!!'
S3BUCKET=s3://TTTservers/DB-backups/$HOSTNAME

echo "DB: $USR@$DB"

set -v

current_time=$(date "+%Y.%m.%d-%H.%M.%S")
file=mongodump-$DB-$current_time.tar.gz

mongodump -u "$USR" -d "$DB" -p "$PWD" -o /tmp/mongodump
#mongodump -u 'twothousand' -d 'database' -p 'TT99!!!' -o /tmp/mongodump

tar -czf /tmp/$file --directory=/tmp/mongodump/database .

aws s3 cp /tmp/$file $S3BUCKET/$file

rm -f /tmp/$file

set +xv
echo
echo "done..."
date --iso=seconds
echo "***********************"
echo
