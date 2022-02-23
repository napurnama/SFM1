mkdir -p ~/log

dtDate=$(date --date='1 hour ago' +"%x" | awk -F"/" '{print $3$2$1}');
dtHour=$(date --date='1 hour ago' +"%X" | awk -F":" '{print $1}');
awk -F"," '
BEGIN{OFS=",";min1=99999;min2=99999;min3=99999;min4=99999;min5=99999;min6=99999;min7=99999;min8=99999;min9=99999;min11=99999} 
$1 < min1 {min1=$1;}
$2 < min2 {min2=$2;}
$3 < min3 {min3=$3;}
$4 < min4 {min4=$4;}
$5 < min5 {min5=$5;}
$6 < min6 {min6=$6;}
$7 < min7 {min7=$7;}
$8 < min8 {min8=$8;}
$9 < min9 {min9=$9;}
$11 < min11 {min11=$11;}
END{print "minimum",min1,min2,min3,min4,min5,min6,min7,min8,min9,$10,min11}' ~/log/metrics_agg_$dtDate$dtHour.log > temp$dtDate$dtHour.log

awk -F"," '
BEGIN{OFS=",";max1=0;max2=0;max3=0;max4=0;max5=0;max6=0;max7=0;max8=0;max9=0;max11=0}
$1 > max1 {max1=$1}
$2 > max2 {max2=$2}
$3 > max3 {max3=$3}
$4 > max4 {max4=$4}
$5 > max5 {max5=$5}
$6 > max6 {max6=$6}
$7 > max7 {max7=$7}
$8 > max8 {max8=$8}
$9 > max9 {max9=$9}
$11 > max11 {max11=$11}
END{print "maximum",max1,max2,max3,max4,max5,max6,max7,max8,max9,$10,max11}' ~/log/metrics_agg_$dtDate$dtHour.log >> temp$dtDate$dtHour.log

awk -F"," 'BEGIN{OFS=",";sum1=0;sum2=0;sum3=0;sum4=0;sum5=0;sum6=0;sum7=0;sum8=0;sum9=0;sum11=0;}
{sum1+=$1;sum2+=$2;sum3+=$3;sum4+=$4;sum5+=$5;sum6+=$6;sum7+=$7;sum8+=$8;sum9+=$9;sum11+=$11}
END{sum1/=NR;sum2/=NR;sum3/=NR;sum4/=NR;sum5/=NR;sum6/=NR;sum7/=NR;sum8/=NR;sum9/=NR;sum11/=NR;print "average",sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8,sum9,$10,sum11}
' ~/log/metrics_agg_$dtDate$dtHour.log >> temp$dtDate$dtHour.log

chmod 700 ~/log/metrics_agg_$dtDate$dtHour.log
cat temp$dtDate$dtHour.log > ~/log/metrics_agg_$dtDate$dtHour.log
chmod 400 ~/log/metrics_agg_$dtDate$dtHour.log

rm temp$dtDate$dtHour.log
