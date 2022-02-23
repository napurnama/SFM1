mkdir -p ~/log

str1=$(free -m | awk 'BEGIN{OFS=","} NR!=1 {for(i=2;i<=NF;i++) printf $i",";}')
str2=$(du -sh ~ | awk 'BEGIN{OFS=","} {print $2,$1}')
dtDate=$(date +"%x" | awk 'BEGIN{FS="/"} {print $3$2$1}')
dtTime=$(date +"%X" | awk 'BEGIN{FS=":"} {print $1$2$3}')
dtHour=$(date +"%X" | awk 'BEGIN{FS=":"} {print $1}')

chmod 600 ~/log/metrics_agg_$dtDate$dtHour.log
echo "$str1$str2" >> ~/log/metrics_$dtDate$dtTime.log
cat ~/log/metrics_$dtDate$dtTime.log >> ~/log/metrics_agg_$dtDate$dtHour.log

chmod 400 ~/log/metrics_agg_$dtDate$dtHour.log
chmod 400 ~/log/metrics_$dtDate$dtTime.log