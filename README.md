A compressed openvino structure of face recognition with models

 to uncompress  ->  cat recon.tar.gz.* | tar xzvf -


to run just modify to your device setting and run recon.pl  which will process names from  facial recognition program and then pass it on to the process.sh  scripts to exec progams on events 

a modified openvino facial recongnition that will process files   on facial recognition and add a face_gallery to your home folder
 - name picture like this paul-01.jpg
   
 modify   recon.pl   with your users and  openvino setting    MYRIAD CPU GPU ..etc
 
  - system("echo '0' > /dev/shm/Scnt");  ## sets the count at start for each user
  - system("echo '0' > /dev/shm/TIME_S"); ## sets epoch at 0 one for each user
  - if ( $cnt0 == 50) {  ## clears counts  after so many bulk counts  since family can have false positives due simularity this aleviats it
  - if ( $PERSON eq "stephen\n" ) {  ## name of the person in you galery

 modify process.sh with your users and the processes you want to happen  either on event or on timed paused event . IE: no sooner then 60 seconds
  - if [ $1 == stephen ]  ## user process point
  - echo "EVENT for Stephen"  ##  add process program  entry point
  - echo "  +60sec Timed event"  ##  times paused. process will only after so much time has elapsed

 but you can add in other processing point  such as 
 
 hour=$(/usr/bin/date +%H)
 
 if ($hours > 9 )  && ($hours < 10 )  ##then it will only process  between this time period of 9am and 10am

 to use MYRIAD device you need openvino==2022.3.2  or lower  if using 
  other openvino  you have to use CPU or gpu or other device 

missing  for processT.sh are the morning, afternoon, evening and  night speech files you need to create them with 49  different lines of text of different greetings or you can reduce the random line selector

speak2 is my elevelabs  speech file it will cache elevenlab speech file and then use them. 

it points to my openwrtAI program for ai listening  when some enters the room. but you can point it other apps if you like

also for the speak elevenlabs app you need to create a voice folder..  but you can pre-test with ./speak2 " hello there"  and see if you get any errors

in your text speach event I use XXXXX as  the denoter for using  the name of the person seen.  " Ie good morning XXXXX  and if the person seen is "paul then it will say "good morning Paul "
