# Usage: python make_tables.py
# Purpose: count GOSlim terms in a representative dataset 
# Flags:
#    -i, --input    : input best blast hits file, tab delimited, three columns 
#    -d, --database : mapping file for locus/gene to GO Slim category 


import argparse
parser = argparse.ArgumentParser()
parser.add_argument('-i', '--input', dest = "input")
parser.add_argument('-d', '--database', dest = "database", default = './TAIR_2021/ATH_GO_GOSLIM_2021.txt')
args = parser.parse_args()
SLIM_DB = args.database
HITS = args.input


import pandas as pd

# Read in best blast hits and subset to include the subject of each hit, replace with column name that matches the GOSlim database 
best_hits = pd.read_table(HITS)
best_hits_S = best_hits[['Subject']]
best_hits_S.columns = ['ObjectName']

# Read in the GOSlim database and add names to each column 
GOSlim_DB = pd.read_table(SLIM_DB, header = None, sep='\t')
GOSlim_DB.columns = ['locus', 'TAIRAccession', 'ObjectName', 'RelationshipType','GOTerm','GOID','TAIRKeywordID','Aspect','GOSlimTerm','EvidenceCode','EvidenceDescription','EvidenceWidth','Ref','Annotator','Date']

# Generate a new df with the locus information 
best_hits_S_locus = pd.DataFrame(best_hits_S['ObjectName'].str.replace('\.[0-9]','', regex = True))
best_hits_S_locus.columns = ['locus']

#Subset the GOSlim database to include only the ObjectName and corresponding GOSlimTerm
GOSlim_DB_OGOSlim_gene = GOSlim_DB[['ObjectName', 'GOSlimTerm']]
GOSlim_DB_GOSlim_locus = GOSlim_DB[['locus', 'GOSlimTerm']]

#Merge the GOSlim database and best hits files
GOSlim_merge_gene = best_hits_S.merge(GOSlim_DB_OGOSlim_gene,'inner', on='ObjectName')  
GOSlim_merge_locus = best_hits_S_locus.merge(GOSlim_DB_GOSlim_locus, 'inner', on='locus')

# Get raw and frequency counts at gene-level only 
rawcounts_gene = GOSlim_merge_gene['GOSlimTerm'].value_counts().sort_index()
rawcounts_gene.to_csv(HITS + '.rawcounts-gene.tsv',sep='\t')

freqcounts_gene = GOSlim_merge_gene['GOSlimTerm'].value_counts(normalize=True).sort_index()
freqcounts_gene.to_csv(HITS + '.freqcounts-gene.tsv',sep='\t')


# Get raw and frequency counts at locus-level 
rawcounts_locus = GOSlim_merge_locus['GOSlimTerm'].value_counts().sort_index()
rawcounts_locus.to_csv(HITS + '.rawcounts-locus.tsv',sep='\t')

freqcounts_locus = GOSlim_merge_locus['GOSlimTerm'].value_counts(normalize=True).sort_index()
freqcounts_locus.to_csv(HITS + '.freqcounts-locus.tsv',sep='\t')

