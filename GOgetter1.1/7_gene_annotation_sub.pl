###################
# Rishi Masalia
# University of Arizona
# Dept. EEB, Barker Lab
#
# Idea: To remove excess info from blast file, to be left with seq id and annotation tag
#
###################

$file = $ARGV[0];
open (INPUT, $file);

open (OUT, ">gene_annotation_$file");

while (<INPUT>){
	chomp $_;
	$_ =~ s/\.\d=\|Symbols.*//g; #REGEXP scheme
	$_ =~ s/=/\t/g;
	@array = split(/\t/, $_, 1); 
	print OUT "@array\n";
}

close INPUT;
close OUT;
exit;
