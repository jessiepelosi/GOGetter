#!/bin/bash 

########################
## GOgetter2.0.sh     ##
## Jessie Pelosi      ##
## 2023               ##
########################

echo "

  _______     _____                        _        _
 /  ____ \   / ___ \                    __| |___ __| |__           
/  /    \_| | /   \ |  _______   _____ |__   __||__   __|  _____    _____
| |    ___  | |   | | /  ___  \ / ___ \   | |      | |    /  __ \  |  _  |
| |   |__ | | |   | | | |   | | | |__| |  | |      | |    | |__| | | / \_|
| |     | | | |   | | | |   | | | ----/   | |      | |    | ____/  | |
| \_____/ | | \___/ | | \___| | | |____   | |__    | |__  | |____  | |
 \_______/   \_____/  \-----  |  \____/   \____|   \____|  \____/  |_|
                            | |
                       _    | |  
                      | |___| |
                      \_______/
"                     


# Unset variables from environment 
unset -v N_THREADS INPUTFILE E_VALUE MAX_TARG_SEQ BLASTDB LENGTH E_VALUE_FILT FILTER DATABASE PROGRAM

# Deafult values 
N_THREADS=1
E_VALUE=0.001
MAX_TARG_SEQ=50
BLASTDB=./TAIR_2021/Araport11_pep_20210622_representative_gene_model
FILTER=evalue
GOSLIMDATABASE="./TAIR_2021/ATH_GO_GOSLIM_2021.txt"
PROGRAM=BLAST
E_VALUE_FILT=0.00001
BITSCORE=0
LENGTH=0
PIDENT=0


Help()
{
   # Display Help
   echo 
   echo "GOgetter v2.1: A tool to summarize and visualize GOSlim annotations for plant genetic data."
   echo
   echo "If you use GOgetter, please cite:"
   echo "GOgetter: A pipeline for summarizing and visualizing obtaining curated GOSlim annotations for plant genetic data by"
   echo "Emily B. Sessa, Rishi R. Masalia, Nils Arrigo, Michael S. Barker, and Jessie A. Pelosi"
   echo
   echo "Usage: bash GOgetter.sh [-t|-i|-e|-s|-d|-n|-l|-p|-b|-v|-f|-D|-h|]"
   echo 
   echo "Options:"
   echo 
   echo "-t    Number of threads to use during BLAST sequence homology search (default: 1)"
   echo "-i    Input file in FASTA format; should be coding sequences of a set of genes"
   echo "-e    Maximum e-value for BLAST search (deafult: 0.001)"
   echo "-s    Maximum number of target sequences for BLAST search (default: 50)"
   echo "-d    BLAST database (default: ./TAIR_2021/Araport11_pep_20210622_representative_gene_model)"
   echo "-n    Use DIAMOND inplace of BLAST"
   echo "-l    Minumum alignment length for filtering BLAST sequence homology search (default: 0)"
   echo "-p    Minimum percent identity for filtering BLAST sequence homology search (deafult: 0)"
   echo "-b    Minimum bitscore for filtering BLAST sequence homology search (default:0)"
   echo "-v    Maximum e-value for fitering BLAST sequence homology search (defualt: 0.00001)"
   echo "-f    Parameters on which to rank/sort BLAST hits (default: evalue; options: evalue, bitscore, length, pident) "
   echo "-D    GOSlim database/mapping file (default: ./TAIR_2021/ATH_GO_GOSLIM_2021.txt)"
   echo 
}

while getopts "t:i:e:s:d:l:p:b:v:f:D:hn" opt; do 
	case "$opt" in 
		(t) N_THREADS=${OPTARG};;	
		(i) INPUTFILE=${OPTARG};;
		(e) E_VALUE=${OPTARG};;
		(s) MAX_TARG_SEQ=${OPTARG};;
		(D) BLASTDB=${OPTARG};;
		(l) LENGTH=${OPTARG};;
		(v) E_VALUE_FILT=${OPTARG};;
		(f) FILTER=${OPTARG};;
		(b) GOSLIMDATABASE=${OPTARG};;
      (p) PIDENT=${OPTARG};;
      (b) BITSCORE=${OPTARG};;
      (n) PROGRAM=${1:-BLAST};;
		(h) # Display help
			Help
			exit;;
	esac
done

echo "GOgetter v2.1"
echo 
echo "If you use GOgetter in your research, please cite: 
GOgetter: A pipeline for summarizing and visualizing GO Slim annotations for plant genetic data.
Sessa, E.B., R. Masalia, N. Arrigo, M.S. Barker, and J.A. Pelosi."
echo 


# Blast query against reference database, the user can change the database as needed; default is Arabidopsis thaliana
if [[ $PROGRAM = "BLAST" ]]; then
	echo "Running GOgetter on $INPUTFILE with BLAST!"
   echo 
   blastx -num_threads $N_THREADS -evalue $E_VALUE -max_target_seqs $MAX_TARG_SEQ -db $BLASTDB -query $INPUTFILE -outfmt 6 -out $INPUTFILE.blast
else
	echo "Running GOgetter on $INPUTFILE with DIAMOND!"
   echo 
   diamond blastx --threads $N_THREADS --evalue $E_VALUE -d $BLASTDB.dmnd --query $INPUTFILE --max-target-seqs $MAX_TARG_SEQ --outfmt 6 --out $INPUTFILE.blast
fi

# Parse blast output to get best hit for each query input sequence, default values and filtering parameters can be changed as needed 
echo 
echo "Assessing best BLAST hits for $INPUTFILE with the following filters:
   Maxmimum e-value: $E_VALUE_FILT
   Minimum percent identity: $PIDENT
   Minimum alignment length: $LENGTH
   Minimum bitscore: $BITSCORE"
echo 
echo "BLAST hits will be sorted by $FILTER!"

python parse_best_hits.py -i $INPUTFILE.blast -l $LENGTH -e $E_VALUE_FILT -p $PIDENT -b $BITSCORE -s $FILTER

# Generate count tables of GOSlim categories 
echo
echo "Generating tables for $INPUTFILE!"
python make_tables.py -i $INPUTFILE.blast.besthits.tsv -d $GOSLIMDATABASE  

echo 
echo "GOgetter has finishied!"
