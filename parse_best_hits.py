'''
Usage:  python parse_blast_best_hits.py 
Purpose: Get best hits for each query in a given blast search
Flags:
    -l, --length : minimum length to consider for blast matches
    -e, --evalue : maximum e-value to consider for blast matches
    -f, --filter : choose best blast hit based on "evalue", "bitscore", or "length"
    -i, --input  : input blast file, must be in outfmt 6   
Default values of filtering: 
     Length = 100bp
     E-value = 1e-5
     Filter based on e-value 
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
LENGTH=100
EVALUE_FILT=0.00001
FILTER="evalue"

import argparse
parser = argparse.ArgumentParser()
parser.add_argument('-i', '--input', dest = "input")
parser.add_argument('-l', '--length', dest = "length", default = 100)
parser.add_argument('-e', '--evalue', dest = "evalue", default = 0.00001)
parser.add_argument('-f', '--filter', dest = "filter", default = 'evalue', choices = ['evalue', 'bitscore','length'])
args = parser.parse_args()
LENGTH = int(args.length)
BLAST = args.input
EVALUE_FILT = float(args.evalue)
FILTER = args.filter 

import pandas as pd
blast_out = pd.read_table(BLAST, header = None, names=["Query", "Subject", "pident", "length", "mismatch", "gapopen","qstart", "qend", "sstart", "send", "evalue", "bitscore"])

blast_filtered = blast_out[(blast_out['length'] > LENGTH) & (blast_out['evalue'] < EVALUE_FILT)]  

if FILTER=="evalue":
    besthits = blast_filtered.groupby(['Query']).apply(lambda x: x.sort_values(['evalue'], ascending = True).head(1))
elif FILTER=="bitscore":
    besthits = blast_filtered.groupby(['Query']).apply(lambda x: x.sort_values(['bitscore'], ascending = False).head(1))
elif FILTER=="length":
    besthits = blast_filtered.groupby(['Query']).apply(lambda x: x.sort_values(['length'], ascending = False).head(1))
else:
    print("No filtering metric provided!")

besthits_QS = besthits[besthits.columns[1:2]]
besthits_QS.to_csv(BLAST + ".besthits.tsv",sep='\t')