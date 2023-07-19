#!/usr/bin/perl

use Getopt::Long;
GetOptions("b=f" => \$b ,
           "h=f" => \$hh ,
           "D=f" => \$D);

#print "Input $b $hh $D \n";

$n=0;
while (<>) {
    $line=$_;
    chomp($line);
    (@list) = split(/\s+/,$line);
    push (@t,$list[0]);
    push (@cct,$list[1]);
    $n+=1;
}

$cinf=$hh;
$inc_limit=1.0e-10;

for ($i=0 ; $i<$n ; $i+=1) {
    
    if ( $t[$i] > 0.0 ) {
       $u = $t[$i] * ($D/$b**2);
       $inc=$inc_limit*2.0;
       $sum=0.0;
       $nn=1;
       while ( $inc > $inc_limit ) {
	   $inc=exp(-$nn*$nn/(4.0*$u));
           $sum+=$inc;
	   $nn+=1;
       }
       $q=(1.0+2.0*$sum)**(3.0); 
       $corr=($q-1.0)/(4.0*3.14159265*$u)**(3.0/2.0);
       $ctout=$cct[$i]-$cinf*$corr;
     }
     else {
       $ctout=1.0
     }

     print "$t[$i]  $ctout\n" ;
}


