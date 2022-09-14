$NAME = "$ARGV[0]";	
open NAME or die "Can't find file $NAME";
open (OUTFILE, ">clean.$NAME");
	while (<NAME>){
		$_ =~ s/\,\E/\t/g;
		$_ =~ s/Query=//g; 
		$_ =~ s/Hit=//g; 
		$_ =~ s/Description=//g;
		$_ =~ s/\t/=/g;
		$_ =~ s/ //g;
		print OUTFILE $_; 
	}

	print "Cleaned up $. lines in file $NAME\n";

exit;
