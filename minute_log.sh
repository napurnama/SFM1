mkdir -p ~/log

str1=$(free -m | awk 'BEGIN{OFS=","} NR!=1 {for(i=2;i<=NF;i++) printf $i",";}')
str2=$(du -sh ~ | awk 'BEGIN{OFS=","} {print $2,$1}')
dtFull=$(date +%F | awk -F"-" 'BEGIN{OFS=""}{print $1$2$3}')
dtTime=$(date +"%X" | awk 'BEGIN{FS=":"} {print $1$2$3}')
dtHour=$(date +"%X" | awk 'BEGIN{FS=":"} {print $1}')

if [[ -f ~/log/metrics_agg_$dtFull$dtHour.log ]]
then
	chmod 600 ~/log/metrics_agg_$dtFull$dtHour.log
fi
echo "$str1$str2" >> ~/log/metrics_$dtFull$dtTime.log
cat ~/log/metrics_$dtFull$dtTime.log >> ~/log/metrics_agg_$dtFull$dtHour.log

chmod 400 ~/log/metrics_agg_$dtFull$dtHour.log
chmod 400 ~/log/metrics_$dtFull$dtTime.log
