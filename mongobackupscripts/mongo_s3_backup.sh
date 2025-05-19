#!/bin/bash

# Remember to chmod this file after copying it
# chmod +x ~/mongobackupscripts/mongo_s3_backup.sh

# Configure crontab
# crontab -e
# 50 7 * * * ~/mongobackupscripts/mongo_s3_backup.sh >> /tmp/mongo_s3_backup.log
# The above runs at 7:50 am UTC or 12:50 am PDT

# This can be used as sample data to test with:
# https://docs.aws.amazon.com/dms/latest/sbs/chap-mongodb2documentdb.02.html

MONGO_BACKUP_FILENAME=$(date "+%H-%M-%S-UTC.mongo_backup" -u)
MONGO_BACKUP_LOGFILE="/tmp/mongo_s3_backup.log"

mongodump -h localhost:27017 --username=root --password=$MONGO_PASSWORD --authenticationDatabase=admin -d go-mongodb -o $MONGO_BACKUP_FILENAME &>>$MONGO_BACKUP_LOGFILE

aws s3 cp $MONGO_BACKUP_FILENAME s3://my-tf-mongo-backup-bucket-for-wiz-testing-environment-akmal/$(date +%m-%d-%y) --recursive &>>$MONGO_BACKUP_LOGFILE

rm -rf $MONGO_BACKUP_FILENAME
