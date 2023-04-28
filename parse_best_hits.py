'''
Usage:  python parse_blast_best_hits.py 
Purpose: Get best hits for each query in a given blast search
Flags:
    -l, --length : minimum length to consider for blast matches
    -e, --evalue : maximum e-value to consider for blast matches
    -p, --pident : minimum percent identity to consider for blast matches 
    -b, --bitscore : minimum bitscore to consider for blast matches 
    -s, --sort : choose best blast hit based on "evalue", "bitscore", "length", or "pident" 
    -i, --input  : input blast file, must be in outfmt 6   
Default values for filtering: 
     E-value = 1e-5
Default values for sorting:
     Sort blast hits based on e-value 

Jessie Pelosi 2023 
'''

# Clear variables 
LENGTH=None
EVALUE_FILT=None
FILTER=None
BLAST=None
blast_out=None
blast_filtered=None
besthits=None
besthits_QS=None

# Set default values 
EVALUE_FILT=0.00001
BITSCORE_FILT=0
LENGTH_FILT=0
PCTID_FILT=0
FILTER="evalue"

import argparse
parser = argparse.ArgumentParser()
parser.add_argument('-i', '--input', dest = "input")
parser.add_argument('-p', '--pident', dest = "pident", default = 0)
parser.add_argument('-l', '--length', dest = "length", default = 0)
parser.add_argument('-e', '--evalue', dest = "evalue", default = 0.00001)
parser.add_argument('-b', '--bitscore', dest="bitscore", default = 0)
parser.add_argument('-s', '--sort', dest = "sort", default = 'evalue', choices = ['evalue', 'bitscore','length','pident'])
args = parser.parse_args()
BLAST = args.input
EVALUE_FILT = float(args.evalue)
LENGTH_FILT = int(args.length)
PCTID_FILT = float(args.pident)
BITSCORE_FILT = float(args.bitscore)
SORTBY = args.sort

import pandas as pd
blast_out = pd.read_table(BLAST, header = None, names=["Query", "Subject", "pident", "length", "mismatch", "gapopen","qstart", "qend", "sstart", "send", "evalue", "bitscore"])

blast_filtered = blast_out[(blast_out['evalue'] < EVALUE_FILT) & (blast_out['bitscore'] > BITSCORE_FILT) & (blast_out['length'] > LENGTH_FILT) & (blast_out['pident'] > PCTID_FILT)]  

if SORTBY=="evalue":
    besthits = blast_filtered.groupby(['Query']).apply(lambda x: x.sort_values(['evalue'], ascending = True).head(1))
elif SORTBY=="bitscore":
    besthits = blast_filtered.groupby(['Query']).apply(lambda x: x.sort_values(['bitscore'], ascending = False).head(1))
elif SORTBY=="length":
    besthits = blast_filtered.groupby(['Query']).apply(lambda x: x.sort_values(['length'], ascending = False).head(1))
elif SORTBY == "pident":
    besthits = blast_filtered.groupby(['Query']).apply(lambda x: x.sort_values(['pident'], ascending = False).head(1))
else:
    print("No sorting metric provided!")

besthits_QS = besthits[besthits.columns[1:2]]
besthits_QS.to_csv(BLAST + ".besthits.tsv",sep='\t')
