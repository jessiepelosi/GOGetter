
#!/bin/bash 

########################
## GOgetter2.0.sh     ##
## Jessie Pelosi      ##
## 2023               ##
########################

# Unset variables from environment 
unset -v N_THREADS INPUTFILE E_VALUE MAX_TARG_SEQ BLASTDB LENGTH E_VALUE_FILT FILTER DATABASE

# Deafult values 
N_THREADS=1
E_VALUE=0.001
MAX_TARG_SEQ=50
BLASTDB=./TAIR_2021/Araport11_pep_20210622_representative_gene_model
LENGTH=100
E_VALUE_FILT=0.00001
FILTER=evalue
GOSLIMDATABASE="./TAIR_2021/ATH_GO_GOSLIM_2021.txt"


Help()
{
   # Display Help
   echo 
   echo "GOgetter v2.0: A tool to summarize and visualize GOSlim annotations for plant genetic data."
   echo
   echo "If you use GOgetter, please cite:"
   echo "GOgetter: A pipeline for summarizing and visualizing obtaining curated GOSlim annotations for plant genetic data by"
   echo "Emily B. Sessa, Rishi R. Masalia, Nils Arrigo, Michael S. Barker, and Jessie A. Pelosi"
   echo
   echo "Usage: bash GOgetter.sh [-t|-i|-e|-s|-d|-l|-v|-f|-b|-h]"
   echo 
   echo "Options:"
   echo 
   echo "-t    Number of threads to use during BLAST sequence homology search (default: 1)"
   echo "-i    Input file in FASTA format; should be coding sequences of a set of genes"
   echo "-e    Maximum e-value for BLAST search (deafult: 0.001)"
   echo "-s    Maximum number of target sequences for BLAST search (default: 50)"
   echo "-d    BLAST database (default: ./TAIR_2021/Araport11_pep_20210622_representative_gene_model)"
   echo "-l    Minumum alignment length for filtering BLAST sequence homology search (default: 100)"
   echo "-v    Maximum e-value for fitering BLAST sequence homology search (defualt: 0.00001)"
   echo "-f    Parameter on which to rank BLAST hits (default: evalue; options: evalue, bitscore, length) "
   echo "-b    GOSlim database/mapping file (default: ./TAIR_2021/ATH_GO_GOSLIM_2021.txt)"
   echo
}

while getopts "t:i:e:s:d:l:v:f:b:h" opt; do 
	case "$opt" in 
		(t) N_THREADS=${OPTARG};;	
		(i) INPUTFILE=${OPTARG};;
		(e) E_VALUE=${OPTARG};;
		(s) MAX_TARG_SEQ=${OPTARG};;
		(d) BLASTDB=${OPTARG};;
		(l) LENGTH=${OPTARG};;
		(v) E_VALUE_FILT=${OPTARG};;
		(f) FILTER=${OPTARG};;
		(b) GOSLIMDATABASE=${OPTARG};;
		(h) # Display help 
			Help
			exit;;
	esac
done


# Blast query against reference database, the user can change the database as needed; default is Arabidopsis thaliana  

blastx -num_threads $N_THREADS -evalue $E_VALUE -max_target_seqs $MAX_TARG_SEQ -db $BLASTDB -query $INPUTFILE -outfmt 6 -out $INPUTFILE.blast	

# Parse blast output to get best hit for each query input sequence, default values and filtering parameters can be changed as needed 

python parse_best_hits.py -i $INPUTFILE.blast -l $LENGTH -e $E_VALUE_FILT -f $FILTER

# Generate count tables of GOSlim categories 

python make_tables.py -i $INPUTFILE.blast.besthits.tsv -d $GOSLIMDATABASE  
