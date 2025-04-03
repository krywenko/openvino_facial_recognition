#!/bin/bash

lastseen=720 ### time span bewteen the  last seen before  recon will re greet you
Repeat=600  ###  minium time period before a function will be repeated
 
sp=1.33  ## Mimic
MPC=$(mpc  | sed -e '/e:/{d;}' |sed -n '1p' | tr -d ' ')  ### checks to see if media player is playing 
mimic='en_US/vctk_low#s5' ## mimic3 voice 'pip3 install mycroft-mimic3-tts[all] ' and voices downloaded from ' git clone https://huggingface.co/mukowaty/mimic3-voices '

hour=$(/usr/bin/date +%H)
day_of_week=$(/usr/bin/date +%u)
r_line=$((1 + $RANDOM % 49))   #### random line selector for speech files

echo  "time " $hour
### set file name for functions #####
SysC=$(echo $1"_cnt")
SysT=$(echo $1"_TIME")
SysG=$(echo $1"_G")
SysI=$(echo $1"_int")
#echo $SysC " " $SysT " "$SysG
##### set file directory ####
DevC=$(echo  "/dev/shm/"$SysC)
DevT=$(echo "/dev/shm/"$SysT)
DevG=$(echo  "/dev/shm/"$SysG)
DevI=$(echo "/dev/shm/"$SysI)
#echo $DevC " " $DevT " "$DevG

INTV=$(cat $DevI )
INTV=$(perl -e "print int('$INTV')")
echo "interval " $INTV 
cnt=$(cat $DevC | bc)  # get count to int
CNT=$(echo $cnt + 1 | bc )  #add to count
if [ $CNT == 2 ]            # event count
then
########## EVENT ##############
######### AI begin Listening ##########
if pgrep -x "openwrtAI.sh" > /dev/null
then
    echo "Running"
else
    echo "AI listening"
  /home/orangepi/OpenwrtAI/./Openwrt.sh  >>/dev/shm/AI 2>&1 & echo "AI running" > /dev/null

fi


echo "EVENT "
echo "0" >$DevC
########## begin event #########
EPOCH=$(date +%s)

###### Last seen interval #######
if (( $EPOCH >= $INTV ))
then 
echo "0" > $DevG
fi
echo $EPOCH + lastseen | bc > $DevI
######################################################
GRT=$(cat $DevG)
echo  "Time of Day " $GRT
######## MORNING #########
if [[ $hour > 18  &&  $hour < 24  &&  $GRT != 1 ]]  ###  my edge device the hardware clock is always 12hrs diffenece
then
if [[ -n $MPC ]] 
then
echo "stopped mpc"
mpc stop
STOP=1
fi
echo "1" > $DevG
echo "time"
LINE=$(sed -n ${r_line}p morning)
echo $LINE | sed "s/XXXXX/${1}/g" > /dev/shm/tmp
#eleven_lab
string=$(cat /dev/shm/tmp)
./speak2 "$string"
#mimic3 --remote  --length-scale $sp --voice  $mimic  < /dev/shm/tmp | aplay 
echo $EPOCH + $Repeat $DevT

fi
############## AFTERNOON ##############
if [[ $hour > 00  &&  $hour < 06  &&  $GRT != 2 ]]  
then
if [[ -n $MPC ]] 
then
echo "stopped mpc"
mpc stop
STOP=1
fi
echo "2" > $DevG
echo "time"
LINE=$(sed -n ${r_line}p afternoon)
echo $LINE | sed "s/XXXXX/${1}/g" > /dev/shm/tmp
#eleven_lab
string=$(cat /dev/shm/tmp)
./speak2 "$string"
#mimic3 --remote  --length-scale $sp --voice  $mimic  < /dev/shm/tmp | aplay 
echo $EPOCH + $Repeat $DevT

fi
########### EVENING ###############
if [[ $hour > 05  &&  $hour < 11  &&  $GRT != 3 ]] 
then
if [[ -n $MPC ]] 
then
echo "stopped mpc"
mpc stop
STOP=1
fi
echo "3" > $DevG
echo "time"
LINE=$(sed -n ${r_line}p evening)
echo $LINE | sed "s/XXXXX/${1}/g"  > /dev/shm/tmp
#eleven_lab
string=$(cat /dev/shm/tmp)
./speak2 "$string"
#mimic3 --remote --length-scale $sp --voice $mimic  < /dev/shm/tmp | aplay 
echo $EPOCH + $Repeat | bc > $DevT

fi
############## NIGHT #################
if [[ $hour > 10  &&  $hour < 15  &&  $GRT != 4 ]] 
then
if [[ -n $MPC ]] 
then
echo "stopped mpc"
mpc stop
STOP=1
fi
echo "4" > $DevG
echo "time"
LINE=$(sed -n ${r_line}p night)
echo $LINE | sed "s/XXXXX/${1}/g" > /dev/shm/tmp
#eleven_lab
string=$(cat /dev/shm/tmp)
./speak2 "$string"
#mimic3 --remote --length-scale $sp --voice $mimic  < /dev/shm/tmp | aplay 
echo $EPOCH + $Repeat  | bc > $DevT

fi
###########################################
TIME=$(cat $DevT)
TIME=$(perl -e "print int('$TIME')")

if (( $TIME <= $EPOCH))
then
echo "                     +60sec Timed event"
if [[ -n $MPC ]] 
then
echo "stopped mpc"
mpc stop
STOP=1
fi
echo $EPOCH + $Repeat  | bc > $DevT
#mimic3 --remote --voice $mimic  ' tick tock . ' | aplay  
######## end #######
fi

######################

else
echo "$CNT" >$DevC
fi



######## restart MPC if it was running previously  ###########

if [[ -n $STOP ]] 
then
sleep 2
mpc play > /dev/null
echo "starting mpc"
fi

