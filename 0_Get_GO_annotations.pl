#########################
#
#	Originally written by Rishi Masalia and Nils Arrigo 
#	Updated by Emily Sessa
#       Last updated by Jessie Pelosi Sept 2022
#
#	On command line: perl 0_Get_GO_annotations.pl <namesfile> $CPU
#
#	<namesfile> is a text file listing the names of the files you want to run through the pipeline. These are FASTA files that have to be present in the Inputs Directory.
#
#	Idea: This pipeline will return GO annotations and best hits in Arabidopsis for a set of unigenes. It will run iteratively through multiple unigenes files listed in the <namesfile>
#
#########################


$NAME = "$ARGV[0]"; #text file containing list of file names to run iteratively through the pipeline
open NAME or die "No file $NAME\n"; #either open that file, or if it can't be found, stop the pipeline
$CPU = "$ARGV[1]"; #the number of CPUs or threads you want to use (this is only relevant for the BLAST step)


while (<NAME>) {
    chomp $_;
	my $file = $_; #this takes a line in the <namesfile> and puts the text of that as $file; each time the pipeline loops, it takes the next line in the file into $file

		print "Starting pipeline for $file!\n\n";
		system ("cp Inputs/$file ."); #copy the file whose name is currently set to $file from the Inputs folder to the current directory, indicated by the .
		
		###Running rename.pl######
		print "Running 1_rename.pl for $file\n\n";	#This renames the header lines in the .unigenes fasta file(s) to be uniformly formatted as: >x##x
		system ("perl 1_rename.pl $file");	#output is renamed_$file
				
		###Running Blast######
		print "Running Blastx for $file\n\n"; #This blasts the unigenes file against an Arabidopsis protein database
		system ("blastx -num_threads $CPU -evalue 0.01 -max_target_seqs 50 -db ./TAIR_2021/Araport11_pep_20210622_representative_gene_model -query renamed_$file -out blasted_$file"); #output is blasted_$file

		###Running athparser.pl############
		print "Running 2_athparser.pl for $file\n\n"; #This parses the BLAST output file, giving one line per hit with only key information saved
		system ("perl 2_athparser.pl blasted_$file"); #output is parsed.blasted_$file

		###Running delete_extra_infoblastx.pl########
		print "Running 3_delete_extra_infoblastx.pl for $file\n\n"; #This cleans the parsed blast output slightly, getting rid of a few extraneous bits of information
		system ("perl 3_delete_extra_infoblastx.pl parsed.blasted_$file"); #output is clean.parsed.blasted_$file

		###Running Besthit.pl##########
		print "Running 4_Besthit.pl for $file\n\n"; #This keeps only the first/best hit for each unigene
		system ("perl 4_Besthit.pl clean.parsed.blasted_$file"); #output is BEST_clean.parsed.blasted_$file

		###Running substitution.pl#########
		print "Running 5_substitution.pl for $file\n\n"; #This deletes everything except the Arabidopsis annotation for each unigene
		system ("perl 5_substitution.pl BEST_clean.parsed.blasted_$file"); #output is annotations_BEST_clean.parsed.blasted_$file

		###Running match.pl###########
		print "Running 6_matchcount.pl for $file\n\n"; #This compares the unigenes annotations to a database of GO terms and pulls all of the GO annotations for each unigene  
		system ("perl 6_matchcount.pl annotations_BEST_clean.parsed.blasted_$file ATH_GO_GOSLIM_2021.txt"); #output is compare_annotations_BEST_clean.parsed.blasted_$file

		###Running gene_annotation_sub.pl############		
		print "Running 7_gene_annotation_sub.pl for $file\n\n"; #This reconstitutes information from a previous intermediate file to give just the renamed unigene and its Arabidopsis best hit annotation
		system ("perl 7_gene_annotation_sub.pl BEST_clean.parsed.blasted_$file"); #output is gene_annotations_BEST_clean.parsed.blasted_$file


		####### Moving & Remove Files ###############

		system ("mv compare_annotations_BEST_clean.parsed.blasted_$file Outputs/");
		system ("mv gene_annotation_BEST_clean.parsed.blasted_$file Outputs/");
	
		system ("rm $file");
		system ("rm renamed_$file");
		system ("rm blasted_$file");
		system ("rm parsed.blasted_$file");
		system ("rm clean.parsed.blasted_$file");
		system ("rm BEST_clean.parsed.blasted_$file");
		system ("rm annotations_BEST_clean.parsed.blasted_$file");

}
