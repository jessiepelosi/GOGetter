##############################
# 	Originally written by Nils Arrigo, Rishi Masalia, Feb 2012
#	Updated by Emily Sessa, Aug 2012
#	UA Dept EEB Barker Lab
#
#	Idea: Compare a list of annotations to a database of annotations and go categories; pull out all GO categories,
#	counted the appropriate number of times a gene is present in your annotations list
#
#############################

$annotation= $ARGV[0];	# should be annotations_BEST_$file
$database = $ARGV[1];	# should be ATH_GO_SLIM

## Get list of accessions (annotations) to keep
open(IN, $annotation);

while (<IN>){
 chomp();
 push @anno_array, $_;
 }
close(IN);

	#print "\nThe first item is $anno_array[0]\n\n";
	#print "The 41st item is $anno_array[40]\n\n";

## Skim through database and print lines when db_array[item] is in @anno_array
open(INPUT, $database);
open(OUT,">compare_$annotation");

while (<INPUT>){
 $line = $_; #$line = the line from file
 @db_array = split(/\t/, $line, 12); #splits the database file by tabs into array "db_array" 
 $acc = $db_array[0]; #$acc = the annotation of that line

	foreach $elem(@anno_array){		#want to match elements from anno_array to elements in db_array...
		if ($acc =~ m/\b$elem/i){ #when an element from the first column of the db_array matches an element from anno_array
			$GO = $db_array[8]; 
  			print OUT "$acc\t$GO\n"; #then print Outfile with annotation and go category
		}
   	}
 }
close OUT;
