mkdir forensic_log_website_daffainfo_log
fileavg="forensic_log_website_daffainfo_log/ratarata.txt"
fileres="forensic_log_website_daffainfo_log/result.txt"

cat log_website_daffainfo.log | awk -F':"' '{print $2}' | awk -F"/" '{print $1,$3}' | awk -F":" '{print $1,$2,$3}' | awk -F " " '{print $1, $3}' > temp_date_time
cat temp_date_time | awk 'NR==2{d1=$1;t1=$2} END{d2=$1;t2=$2; print "Rata-rata serangan adalah sebanyak "(NR-1)/(t2+24*(d2-d1)-t1+1)" requests per jam"}' > $fileavg

rm temp_date_time

cat log_website_daffainfo.log | awk -F'"' '{print $2}' | awk '{a[$1]++} END{for(n in a) print a[n], n}' | awk 'BEGIN{max=0} $1 > max{max=$1} END{print "IP yang paling banyak mengakses server adalah: "$2" sebanyak "max" requests"}' > $fileres

cat log_website_daffainfo.log | grep "curl" | awk 'END {print "Ada "NR" requests yang menggunakan curl sebagai user-agent"}' >> $fileres

cat log_website_daffainfo.log | grep "curl" | awk -F'"' '{print $2, $4}' | awk -F':' '{print $1,$2}' | awk '{printf "%s Jam %d ", $1, $3; if($3 >= 1 && $3 < 12)print "pagi"; if($3 >= 12 && $3 < 15) print "siang"; if($3 >= 15 && $3 < 18) print "sore"}' >> $fileres
