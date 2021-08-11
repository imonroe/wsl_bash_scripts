#!/usr/bin/env bash

ps -C apache2 > /dev/null
apachestatus=$?
ps -C mysqld > /dev/null
mysqlstatus=$?
if [[ $apachestatus -eq 0 && $mysqlstatus -eq 0 ]]; then
  echo "Your stack appears to be running."
#  echo "apachestatus $apachestatus"
#  echo "mysqlstatus $mysqlstatus"
  exit 0
else
  echo "your stack appears to be down"
#  echo "apachestatus $apachestatus"
#  echo "mysqlstatus $mysqlstatus"
  exit 1
fi

