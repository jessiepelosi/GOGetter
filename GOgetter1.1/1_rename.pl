###################
# Emily Sessa
# University of Arizona
# Dept. EEB, Barker Lab
#
# Idea: To find all the schemes in a fasta file and replace them with x####x, which will be recognized in all later scripts in the pipeline. This should be the only step that requires curation when you want to begin with a new file - you'll have to figure out what the schemes are and replace them here.
#
#
###################

$file = $ARGV[0];
open (INPUT, $file);

open (OUT, ">renamed_$file");

$num = 0;

while (<INPUT>){
	chomp $_;
	if ($_ =~ /^[A-Z]/) {
		print OUT "$_\n";
		}
	elsif ($_ =~ /^>/) {
		$num = $num+1;	
		$_ =~ s/\>.*/>x${num}x/g;
		print OUT "$_\n";
		}
	}

close INPUT;
close OUT;
exit;