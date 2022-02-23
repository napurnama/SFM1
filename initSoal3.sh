mkdir -p ~/log
chmod 711 minute_log.sh
chmod 711 aggregate_minutes_to_hourly_log.sh
crontab -l > crontab_temp
echo "* * * * * ~/Downloads/gitTest/soal3/minute_log.sh" >> crontab_temp
echo "59 * * * * ~/Downloads/gitTest/soal3/aggregate_minutes_to_hourly_log.sh" >> crontab_temp
crontab crontab_temp
rm crontab_temp
