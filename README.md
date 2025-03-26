a modified openvino facial recongnition that will process files   on facial recognition and add a face_gallery to your home folder
 - name picture like this paul-01.jpg
   
 modify   recon.pl   with your users and  openvino setting   currently it set at MYRIAD
 -system("echo '0' > /dev/shm/Scnt");  ## sets the count at start for each user
 -system("echo '0' > /dev/shm/TIME_S"); ## sets epoch at 0 one for each user
 -if ( $cnt0 == 50) {  ## clears counts  after so many bulk counts  since family can have false positives due simularity this aleviats it
 -if ( $PERSON eq "stephen\n" ) {  ## name of the person in you galery

 modify process.sh with your users and the processes you want to happen  either on event of on timed paused event . IE: no sooner the 60 seconds
  - if [ $1 == stephen ]  ## user process point
  - echo "EVENT for Stephen"  ##  add process program  entry point
  - echo "  +60sec Timed event"  ##  times paused. process will only after so much time has elapsed

 but you can add in other procewssing point  such as 
 hour=$(/usr/bin/date +%H)
 if ($hours > 9 )  && ($hours < 10 )  ##then it will only process  between this time period
