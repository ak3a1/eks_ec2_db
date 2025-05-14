#!/bin/bash

# Remember to chmod this file after copying it
# chmod +x ~/mongobackupscripts/mongo_s3_backup.sh

# Configure crontab
# crontab -e
# 50 7 * * * ~/mongobackupscripts/mongo_s3_backup.sh >> /tmp/mongo_s3_backup.log
# The above runs at 7:50 am UTC or 12:50 am PDT

MONGO_BACKUP_FILENAME=$(date "+%H-%M-%S-UTC.mongo_backup" -u)

mongodump -h localhost:27017 -d my_mongo_db_name -o $MONGO_BACKUP_FILENAME

aws s3 cp $MONGO_BACKUP_FILENAME s3://my-tf-mongo-backup-bucket-for-wiz-testing-environment-akmal/$(date +%m-%d-%y)/

rm $MONGO_BACKUP_FILENAME
