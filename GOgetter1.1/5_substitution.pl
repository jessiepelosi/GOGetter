###################
# Rishi Masalia
# University of Arizona
# Dept. EEB, Barker Lab
#
# Idea: To remove excess info from blast file, to be left with annotation tag
#
###################

$file = $ARGV[0];
open (INPUT, $file);

open (OUT, ">annotations_$file");

while (<INPUT>){
	chomp $_;
	$_ =~ s/\..*//g; #this gets rid of everything after a period
	$_ =~ s/x\d+x=//g; #this gets rid of x###x
	print OUT "$_\n";
}

close INPUT;
close OUT;
exit;
