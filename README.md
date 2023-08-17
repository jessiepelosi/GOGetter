# GOGetter

Scripts for the GOgetter pipeline, a set of python and bash scripts to summarize and visualize GO Slim terms in of one or more sets of genes. If you use this pipeline, please cite the following paper: 

Sessa, E.B., R.R. Masalia, N. Arrigo, M.S. Barker, and J.A. Pelosi. 2023. GOgetter: A pipeline for summarizing and visualizing GO slim annotations for plant genetic data. Applications in Plant Sciences 11(4): e11536. https://doi.org/10.1002/aps3.11536 

## Change Log 

<b>GOgetter v2.1</b>

* Built in DIAMOND as alternative to BLAST (BLAST remains default sequence homology search program)
* Renamed `GOgetter2.0.sh` to `GOgetter.sh`
* In `parse_best_hits.py` removed default length filter and added in optional filter and sort by percent identity 
* Renamed `merge_tables.py` to `merge_and_viz.py`
* In `merge_and_viz.py` added additional visualization methods including pie charts, barplots, and bubble graphs with new flags; new flag to allow users to skip visualization and only merge tables from `GOgetter.sh`. 

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
* seaborn 0.11.2

2. NCBI Blast 2.10.1 (or DIAMOND 2.1.3.157)

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
for file in examples/*.fasta; do bash GOgetter.sh -i "$file";done
```
This will generate four count `*.tsv` files for each input file, the `*.blast` and `*.blast.besthit.tsv`. The outputs for these files can be found in `examples/outfiles/`. 

To merge the files and generate some figures: 
```
python merge_and_viz.py -m both -g all -o examples $(ls *.freqcounts-gene.tsv)
```
This script will generate several output files: `examples_aggregatedTable.tsv`, `examples_barGraph.png`, `examples_bubbleGraph`, `examples_heatmap.png`, `example_heatmap_lognorm.png`, and one pie chart file for each input. The outputs for these files can be found in `examples/outfiles/`. 

<b>The Pipeline </b> 

![GOgetter Pipeline figure](https://github.com/jessiepelosi/GOGetter/blob/main/GOgetter_pipeline.png)

For each input file, GOgetter can be run with `GOgetter.sh` which 1) uses BLAST (or DIAMOND; BLAST is default) to find significant sequence similarity matches, 2) parses the best BLAST hit for each locus (`parse_best_hits.py`), and 3) generates summary tables that characterize the GOSlim composition of the input (`make_tables.py`). An additional python script (`merge_and_viz.py`) can be run to merge and visualize the resulting summary tables. The output from the main bash script are tables summarizing the raw and frequency counts of GOSlim terms in the input gene set. Make sure to unzip the `.gz` file of the deafult GO Slim database in the `TAIR_2021` directory. 

<i>BLAST</i>

By default, `GOgetter.sh` calls the following blastx command: 
```
blastx -num_threads $N_THREADS -evalue $E_VALUE -max_target_seqs $MAX_TARG_SEQ -db $BLASTDB -query $INPUTFILE -outfmt 6 -out $INPUTFILE.blast	
```
Output from the BLAST search will be `$INPUTFILE.blast`. 

The following options are available to change the BLAST parameters when calling the `GOgetter.sh`: 
```
-t    Number of threads to use during BLAST sequence homology search (default: 1)
-i    Input file in FASTA format; should be coding sequences of a set of genes
-e    Maximum e-value for BLAST search (deafult: 0.001)
-s    Maximum number of target sequences for BLAST search (default: 50)
-d    BLAST database (default: ./TAIR_2021/Araport11_pep_20210622_representative_gene_model)
```

By using the `-n` flag when calling `GOgetter.sh`, you can instead call DIAMOND rather than BLAST. DIAMOND must be in your path. `GOgetter.sh` calls the following command: 

```
diamond blastx --threads $N_THREADS --evalue $E_VALUE -d $BLASTDB.dmnd --query $INPUTFILE --max-target-seqs $MAX_TARG_SEQ --outfmt 6 --out $INPUTFILE.blast
```

Independent BLAST or DIAMOND searches can also be passed to the next python script, but must be in the BLAST out format 6. 

<i>Parsing Best Hits</i>

The python script `parse_best_hits.py` is used to filter and rank the best BLAST hits for each sequence. Within `GOgetter.sh` the script is called with the following command:  
```
python parse_best_hits.py -i $INPUTFILE.blast -l $LENGTH -e $E_VALUE_FILT -p $PIDENT -b $BITSCORE -s $FILTER
```
The output from `parse_best_hits.py` is a tab-delimited file (`$INPUTFILE.blast.besthits.tsv`) with a one-to-one association of the query (input sequences) to the subject (reference in the BLAST database). By deafult, the script will filter out hits with e-values greater than 0.00001 and the ranking of hits are based on e-value. From the main bash script, the following flags can be used to change these parameters: 

```
-l    Minumum alignment length for filtering BLAST sequence homology search (default: 0)
-p    Minimum percent identity for filtering BLAST sequence homology search (default: 0)
-b    Minimum bitscore for filtering BLAST sequence homology search (default:0)
-v    Maximum e-value for fitering BLAST sequence homology search (default: 0.00001)
-f    Parameters on which to rank/sort BLAST hits (default: evalue; options: evalue, bitscore, length, pident
```

If the python script is called independently of the bash script, it can done as so: 
```
python parse_best_hits.py -i [input_file.blast]
```
With the options: 
```
-i, --input    : input BLAST output file (.blast), must be in outfmt 6 
-l, --length   : minimum length to consider for blast matches
-p, --pident   : minimum percent identity to consider for blast matches
-b, --bitscore : minimum bitscore to consider for blast matches 
-e, --evalue   : maximum e-value to consider for blast matches (default: 0.00001)
-f, --filter   : choose best blast hit based on "evalue", "bitscore", "length", or "pident"
```
<i>Making tables</i>

The last script called by the main bash script is `make_tables.py` that generates a raw and frequency table of each GOSlim cateogry based on a GOSlim mapping file at the locus and gene level (e.g., `$INPUTFILE.blast.besthit.freqcount-gene`). 

Within `GOgetter.sh` the script is called with the following command:  
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

<i>Merging Tables and Data Visualization (Optional)</i>

An additional python script is provided outside of `GOgetter.sh` that allows users to merge tables from multiple samples output from `make_tables.py`. It is run as: 
```
python merge_and_viz.py -m [both or merge] -g [all, bar, heatmap, bubble, pie, none] -o [outfile prefix] file1.tsv file2.tsv ... filen.tsv 
```
Users may list each file individually, or, within a directory, can be run like so: 
```
python merge_and_viz.py -m [both or merge] -g [all, bar, heatmap, bubble, pie, none] -o [outfile prefix] $(ls *freqcounts-locus.tsv)
```
The output from `merge_and_viz.py` will depend on the runmode employed. With `-m merge`, only an aggregated table will be generated from the input files. 
```
python merge_and_viz.py -m merge -g none -o test $(ls *freqcounts-locus.tsv)
```
Output will be `test_aggregatedTable.tsv`. 

If you want to visualize the aggregated table, you should run with the `both` runmode (`-m both`). 
```
python merge_and_viz.py -m both -g all -o test $(ls *freqcounts-locus.tsv)
```
Several visualizations will be generated as well as the `test_aggregatedTable.tsv`. The visualizations are: 
```
-g all     : all visualizations (bar, bubble, heatmaps, pie charts)
-g pie     : pie charts, one output for each input 
-g bar     : barplot of porportions of each input annotated to GO Slims 
-g heatmap : heatmaps, both raw and log-normalized 
-g bubble  : bubble plot, where bubbles are proportional to frequencies 
-g none    : no visualizations will be generated
```
To see all options: 
```
python merge_and_giz.py [-m {both,merge}] [-g {all,bar,heatmap,bubble,pie,none}] [-o OUT] [file [file ...]]

-m, --mode    : runmode, choices are both or merge
-g, --graph   : type of visualization, choices are all, bar, heatmap, bubble, pie, none
-o, --out     : prefix for output files 
```
The list of input files is a positional argument that should follow the last of the keyword (flag) arguments 

<b>Full Set of Commands Help </b> 

To view the full set of options from `GOgetter.sh`, run: 

```
bash Gogetter.sh -h
```

```


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


GOgetter v2.1: A tool to summarize and visualize GOSlim annotations for plant genetic data.

If you use GOgetter, please cite:
GOgetter: A pipeline for summarizing and visualizing obtaining curated GOSlim annotations for plant genetic data by
Emily B. Sessa, Rishi R. Masalia, Nils Arrigo, Michael S. Barker, and Jessie A. Pelosi

Usage: bash GOgetter.sh [-t|-i|-e|-s|-d|-n|-l|-p|-b|-v|-f|-D|-h|]

Options:

-t    Number of threads to use during BLAST sequence homology search (default: 1)
-i    Input file in FASTA format; should be coding sequences of a set of genes
-e    Maximum e-value for BLAST search (default: 0.001)
-s    Maximum number of target sequences for BLAST search (default: 50)
-d    BLAST database (default: ./TAIR_2021/Araport11_pep_20210622_representative_gene_model)
-n    Use DIAMOND inplace of BLAST
-l    Minumum alignment length for filtering BLAST sequence homology search (default: 0)
-p    Minimum percent identity for filtering BLAST sequence homology search (default: 0)
-b    Minimum bitscore for filtering BLAST sequence homology search (default:0)
-v    Maximum e-value for fitering BLAST sequence homology search (default: 0.00001)
-f    Parameters on which to rank/sort BLAST hits (default: evalue; options: evalue, bitscore, length, pident) 
-D    GOSlim database/mapping file (default: ./TAIR_2021/ATH_GO_GOSLIM_2021.txt)

```
