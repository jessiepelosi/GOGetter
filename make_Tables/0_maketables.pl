#############
#	Emily Sessa, Aug 2012
#	Barker lab, UA EEB
#	Usage: perl 0_maketables.pl [names.txt]
# 	Updated by Jessie Pelosi, University of Florida 
# 	September 2022
#############

$NAME = "$ARGV[0]"; #text file containing list of file names to run iteratively through the pipeline
open NAME or die "No file $NAME\n";

while (<NAME>) {
	chomp $_;
	my $file = $_; #all $file names are <species>.unigenes

		print "Making folders\n";				
		system ("mkdir All_tables_$file");			
		system ("mkdir raw_tables");
		system ("mkdir freq_tables");
		
			####### Makes a table with raw count of each GO Category for that file #########
			print "Making RAW count GO table for $file\n\n";
			system ("perl 1_maketable_raw.pl $file");
			system ("mv rawTable_$file raw_tables/");
			
			####### Makes a table with frequency of each GO Category for that file #########
			print "Making FREQUENCY count GO table for $file\n\n";
			system ("perl 2_maketable_freq.pl $file");
			system ("mv freqTable_$file freq_tables/");
			
			####### Make final .csv file for each frequency file #######
			print "Replacing commas in GO Slim Categories for $file\n\n";
			system ("bash 3_sed_GOSlim.sh -f freq_tables/freqTable_$file");
			system ("bash 3_sed_GOSlim.sh -f raw_tables/rawTable_$file");

	####### Runs script to make .csv files containing either the raw or frequency counts for all species ############
	print "Making Excel file for all frequency counts\n\n";
	system ("perl 4_make_csv.pl freq_tables 1 freq_$file.csv");
	system ("mv freq_$file.csv All_tables_$file/");
	
	print "Making Excel file for all raw counts\n\n";
	system ("perl 4_make_csv.pl raw_tables 1 raw_$file.csv");
	system ("mv raw_$file.csv All_tables_$file/");

	print "Adding row names for $file\n\n";
	system ("bash 5_addRows.sh -f All_tables_$file/freq_$file.csv");
	system ("bash 5_addRows.sh -f All_tables_$file/raw_$file.csv");

	system ("rm -r freq_tables/");
	system ("rm -r raw_tables/");	

}
	
	
