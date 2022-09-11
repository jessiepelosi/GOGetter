# GOGetter

Scripts for the GOGetter pipeline. If you use this pipeline, please cite the following paper: 

Sessa, E.B., J.A. Pelosi, XX, XX, M.S. Barker. GOGetter... blah blah. 

<b>Dependencies:</b> 
1. perl 
2. NCBI Blast (in path) 

<b>Basic usage:</b>

GOGetter is split into two major perl wrapper scripts. The first script `0_Get_GO_annotations.pl` will blast a set of genes against the <i>Arabidopsis thaliana</i> TAIR10.1 genome annotation to assign GO Slim categories to genes in the input. Input files should be listed in a plain text document (e.g., `names.txt`) with the file name for each transcriptome, set of genes, etc. on a separate line. All input files should be placed in the `Inputs` subdirectory. Three example files are currently in this directory, but can be deleted as necessary. To run the first set of scripts for GOGetter:
```
perl 0_Get_GO_annotations.pl [names.txt] [number of CPUs]
```
The output from these 

The second wrapper script is located in the `make_Tables` subdirectory as `0_makeTables.pl`. These scripts will generate raw (count) and frequency tallies of genes annotated to a GO Slim category after running through the above steps. To run this set of scripts: 
```
perl 0_makeTables.pl [names.txt]
```

