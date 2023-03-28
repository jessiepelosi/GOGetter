# GOGetter

Scripts for the GOgetter pipeline, a set of python and bash scripts to summarize and visualize GO Slim terms in of one or more sets of genes. If you use this pipeline, please cite the following paper: 

Sessa, E.B., R. Masalia, N. Arrigo, M.S. Barker, and J.A. Pelosi. GOgetter: A pipeline for summarizing and visualizing GO Slim annotations for plant genetic data. 

## Change Log 

<b>GOgetter v2.0</b> 

* Re-written in python3 and increase flexibility of pipeline, allows user to change blast parameters and use a custom database 

<b>GOgetter v1.1</b> 

* Update GOSlim database to TAIR10 

<b>GOgetter v1.0</b> 

* Original release 

## Dependencies 
1. Python 3.8 
* argparse 1.1
* matplotlib 3.3.0
* numpy 1.20.2
* pandas 1.2.4
* re 2.2.1

2. NCBI Blast 2.10.1

## Usage

<b>Installation</b> 

GOgetter can be installed by cloning the GitHub repository.
```
git clone https://github.com/jessiepelosi/GOGetter.git
```

<b>Examples</b>

To loop through the example files, first `cd` into the directory and run a for-loop and unzip the default GO Slim database file.  
```
cd GOGetter/TAIR_2021/
gunzip ATH_GO_GOSLIM_2021.txt.gz
cd ..
for file in examples/*.fasta; do bash GOgetter2.0.sh -i "$file";done
```
This will generate four count `*.tsv` files for each input file, the `*.blast` and `*.blast.besthit.tsv`. The outputs for these files can be found in `examples/outfiles/`. 

To merge the files and generate some heatmaps: 
```
python merge_tables.py $(ls *.freqcounts-gene.tsv)
```
This script will generate three output files: `GOSlim_aggregated.tsv`, `GOSlim_heatmap.png`, and `GOSlim_heatmap_lognorm.png`. The outputs for these files can be found in `examples/outfiles/`. 

<b>The Pipeline </b> 

For each input file, GOgetter can be run with `GOgetter2.0.sh` which 1) uses BLAST to find significant sequence similarity matches, 2) parses the best BLAST hit for each locus (`parse_best_hits.py`), and 3) generates summary tables that characterize the GOSlim composition of the input (`make_tables.py`). An additional python script (`merge_tables.py`) can be run to merge and visualize the resulting summary tables. The output from the main bash script are tables summarizing the raw and frequency counts of GOSlim terms in the input gene set. Make sure to unzip the `.zip` file of the deafult GO Slim database in the `TAIR_2021` directory. 

<i>BLAST</i>

By default, `GOgetter2.0.sh` calls the following blastx command: 
```
blastx -num_threads $N_THREADS -evalue $E_VALUE -max_target_seqs $MAX_TARG_SEQ -db $BLASTDB -query $INPUTFILE -outfmt 6 -out $INPUTFILE.blast	
```
Output from the BLAST search will be `$INPUTFILE.blast`. 

The following options are available to change the BLAST parameters when calling the `GOgetter2.0.sh`: 
```
-t    Number of threads to use during BLAST sequence homology search (default: 1)
-i    Input file in FASTA format; should be coding sequences of a set of genes
-e    Maximum e-value for BLAST search (deafult: 0.001)
-s    Maximum number of target sequences for BLAST search (default: 50)
-d    BLAST database (default: ./TAIR_2021/Araport11_pep_20210622_representative_gene_model)
```

Independent BLAST or DIAMOND searches can also be passed to the next python script, but must be in the BLAST out format 6. 

<i>Parsing Best Hits</i>

The python script `parse_best_hits.py` is used to filter and rank the best BLAST hits for each sequence. Within `GOgetter2.0.sh` the script is called with the following command:  
```
python parse_best_hits.py -i $INPUTFILE.blast -l $LENGTH -e $E_VALUE_FILT -f $FILTER
```
The output from `parse_best_hits.py` is a tab-delimited file (`$INPUTFILE.blast.besthits.tsv`) with a one-to-one association of the query (input sequences) to the subject (reference in the BLAST database). By deafult, the script will filter out hits with alignment lengths less than 100bp and e-values greater than 0.00001 and the ranking of hits are based on e-value. From the main bash script, the following flags can be used to change these parameters: 

```
-l    Minumum alignment length for filtering BLAST sequence homology search (default: 100)
-v    Maximum e-value for fitering BLAST sequence homology search (defualt: 0.00001)
-f    Parameter on which to rank BLAST hits (default: evalue; options: evalue, bitscore, length) 
```

If the python script is called independently of the bash script, it can done as so: 
```
python parse_best_hits.py -i [input_file.blast]
```
With the options: 
```
-l, --length : minimum length to consider for blast matches (default: 100)
-e, --evalue : maximum e-value to consider for blast matches (deafult: 0.00001)
-f, --filter : choose best blast hit based on "evalue", "bitscore", or "length"
-i, --input  : input blast file, must be in outfmt 6   
```
<i>Making tables</i>

The last script called by the main bash script is `make_tables.py` that generates a raw and frequency table of each GOSlim cateogry based on a GOSlim mapping file at the locus and gene level (e.g., `$INPUTFILE.blast.besthit.freqcount-gene`). 

Within `GOgetter2.0.sh` the script is called with the following command:  
```
python make_tables.py -i $INPUTFILE.blast.besthits.tsv -d $GOSLIMDATABASE  
```

If the python script is called independently of the bash script, it can done as so: 

```
python make_tables.py -i [input_file.blast]
```

With the options: 
```
-i, --input    : input best blast hits file, tab delimited, three columns 
-d, --database : mapping file for locus/gene to GO Slim category 
```

<i>Merging Tables (Optional)</i>

An additional python script is provided outside of `GOgetter2.0.sh` that allows users to merge tables from multiple samples output from `make_tables.py`. It is run as: 
```
python merge_tables.py file1.tsv file2.tsv ... filen.tsv 
```
Users may list each file individually, or, within a directory, can be run like so: 
```
python merge_tables.py $(ls *freqcounts-locus.tsv)
```
The output from `merge_tables.py` is an aggregated table based on an outer join of the input tables (`GOSlim_aggregated.tsv`), a heatmap of the frequency of each GOSlim category (`GOSlim_heatmap.png`), and heatmap based on log normalization (`GOSlim_heatmap_lognorm.png`). <b>Note</b>: The heatmaps are most helpful for visualizing the frequency count tables, the aggregated table may be most useful for the raw counts data.  

<b>Full Set of Commands Help </b> 

To view the full set of options from `GOgetter2.0.sh`, run: 

```
bash Gogetter2.0.sh -h
```

```
GOgetter v2.0: A tool to summarize and visualize GOSlim annotations for plant genetic data.

If you use GOgetter, please cite:
GOgetter: A pipeline for summarizing and visualizing obtaining curated GOSlim annotations for plant genetic data by
Emily B. Sessa, Rishi R. Masalia, Nils Arrigo, Michael S. Barker, and Jessie A. Pelosi

Usage: bash GOgetter.sh [-t|-i|-e|-s|-d|-l|-v|-f|-b|-h]

Options:

-t    Number of threads to use during BLAST sequence homology search (default: 1)
-i    Input file in FASTA format; should be coding sequences of a set of genes
-e    Maximum e-value for BLAST search (deafult: 0.001)
-s    Maximum number of target sequences for BLAST search (default: 50)
-d    BLAST database (default: ./TAIR_2021/Araport11_pep_20210622_representative_gene_model)
-l    Minumum alignment length for filtering BLAST sequence homology search (default: 100)
-v    Maximum e-value for fitering BLAST sequence homology search (defualt: 0.00001)
-f    Parameter on which to rank BLAST hits (default: evalue; options: evalue, bitscore, length) 
-b    GOSlim database/mapping file (default: ./TAIR_2021/ATH_GO_GOSLIM_2021.txt)
```
