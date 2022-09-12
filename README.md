# GOGetter

Scripts for the GOGetter pipeline. If you use this pipeline, please cite the following paper: 

Sessa, E.B., J.A. Pelosi, XX, XX, M.S. Barker. GOGetter... blah blah. 

## Dependencies 
1. perl 
2. NCBI Blast (in path) 

## Basic usage

GOGetter is split into two major perl wrapper scripts. The first script `0_Get_GO_annotations.pl` will blast a set of genes against the <i>Arabidopsis thaliana</i> TAIR10.1 genome annotation to assign GO Slim categories to genes in the input. Input files should be listed in a plain text document (e.g., `names.txt`) with the file name for each transcriptome, set of genes, etc. on a separate line. All input files should be placed in the `Inputs` subdirectory. Three example files are currently in this directory, but can be deleted as necessary. To run the first set of scripts for GOGetter:
```
perl 0_Get_GO_annotations.pl [names.txt] [number of CPUs]
```
The output from these scripts will be located in the `Outputs` subdirectory and are named 
```
compare_annotations_BEST_clean.parsed.blasted_[sample name]
gene_annotation_BEST_clean.parsed.blasted_[sample name]
```
The gene annotation file will contain the TAIR10 best blast hits. The compare annotation file lists the corresponding functioal GO Slim cateogry to the TAIR10 best blast hits. 

The second wrapper script is located in the `make_Tables` subdirectory as `0_makeTables.pl`. These scripts will generate raw (count) and frequency tallies of genes annotated to a GO Slim category after running through the above steps. These scripts should take the compare annotation files, which should be in the `make_Tables` directory. You can copy these files like: 
```
cd make_Tables
cp ../Outputs/compare_annotations* . 
```
The input for the major wrapper script is again a plain text file that contains names of the compare annotation files. Once the files are copied into this directory, this file can be generated by:
```
ls compare_annotations* > names.txt 
```
To run this set of scripts: 
```
perl 0_makeTables.pl [names.txt]
```
The outputs from these scripts will be in separate directories for each input file, with `All_tables` prefixed to the file name. Each directory will contain a raw count and frequency tables for the number of genes in the input annotated to GO Slim categories. 
