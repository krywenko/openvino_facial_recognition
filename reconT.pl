#!/usr/bin/perl -w

use Cwd qw(abs_path);
my $path = abs_path($0);
$path=~ s/\/reconT.pl//g;  #### change to match file name
print "$path\n";

##########################

@names = ("stephen", "astrid", "eric","marcus","sasha");
$CNt="_cnt";
$Time="_TIME";
$Gtime="_G";
$InterV="_int";
foreach my $item (@names) {
  print "$item\n";
   $Cnt=$item.$CNt;
  print "$Cnt\n";
  system("echo '0' > /dev/shm/$Cnt");
   $Cnt=$item.$Time;
  print "$Cnt\n";
  system("echo '0' > /dev/shm/$Cnt");
   $Cnt=$item.$Gtime;
  print "$Cnt\n";
  system("echo '0' > /dev/shm/$Cnt");  
   $Cnt=$item.$InterV;
  print "$Cnt\n";
  system("echo '0' > /dev/shm/$Cnt");    
}
##########################

print "Started face recognition\n";



open(SUB, "python3 $path/face_recognition_demo.py -i /dev/video0 -m_fd public/face-detection-retail-0044/FP16/face-detection-retail-0044.xml -m_lm intel/landmarks-regression-retail-0009/FP16/landmarks-regression-retail-0009.xml -m_reid intel/face-reidentification-retail-0095/FP16/face-reidentification-retail-0095.xml --verbose -d_fd MYRIAD -d_lm MYRIAD -d_reid MYRIAD -fg '/home/orangepi/face_gallery'   --no_show |");




while ($PERSON = <SUB>) {
$PERSON =~ tr/[]//d;
$PERSON =~  s/INFO //;
$PERSON =~ tr/ //ds;


$cnt0++;
if ( $cnt0 == 50) {
$cnt = 0;
$cnt1 = 0;
$cnt2 = 0;
$cnt3 = 0;
$cnt4 = 0;
}


if ( $PERSON eq "stephen\n" ) {
$cnt1++;

##### PRINT NAME #####
if  ($cnt1 == 10 ){
print "stephen\n";
$cnt1=0;
system("$path/./processT.sh $PERSON");
}

}

if ( $PERSON eq "sasha\n" ) {
$cnt2++;
if  ($cnt2 == 10 ){
print "sasha\n";
$cnt2=0;
system("$path/./processT.sh $PERSON");
}

}

if ( $PERSON eq "astrid\n" ) {

 $cnt++;
 if ($cnt == 10) {
print "astrid\n";	 
$cnt=0;
system("$path/./processT.sh $PERSON");
}

}

if ( $PERSON eq "eric\n" ) {
$cnt4++;
if  ($cnt4 == 10 ){
print "eric\n";
system("$path/./processT.sh $PERSON");
}
}
if ( $PERSON eq "marcus\n" ) {
$cnt3++;
if  ($cnt3 == 10 ){
print "marcus\n";
system("$path/./processT       .sh $PERSON");
}
}


}

