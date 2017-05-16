#!/bin/bash


#Enter university seat number (VTU USN)
echo Enter VTU USN: 
read USN

while true
do

(curl -s "http://results.vtu.ac.in/results/result_page.php?usn=$USN" > results.txt) > /dev/null & sleep 30
kill $! 2>/dev/null

RES1=$(grep -oh University\ Seat\ Number\ is\ not\ available\ or\ Invalid results.txt)
RES2=$(grep -oh Total\ Marks results.txt)

if [ "$RES1" == "University Seat Number is not available or Invalid" ]
then
echo No Declared "[x]"
elif [ "$RES2" == "Total Marks" ]
then
#Play song named NV.mp3 in background: at volume 1 for 220s
afplay -v 1 -t 220 NV.mp3 &
dialog --msgbox http://results.vtu.ac.in/results/result_page.php?usn=$USN 10 80
elif [[ -z "$RES1" ]]
then
echo No Response "[?]"
clear
fi

touch attempts.txt
ATT=$(cat attempts.txt)
ATT=$((ATT+1))
echo ____________________________________________________________
echo Attempt no: $ATT
echo $ATT > attempts.txt

done #End of infinite while


exit
