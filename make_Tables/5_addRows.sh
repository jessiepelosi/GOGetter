##################################################
## bash 5_addRows.sh -f [table_file.csv]
## Written by Jessie Pelosi, University of Florida 
## Purpose: append csvs with row names 
## Last Updated: September 12, 2022
##################################################

#!/bin/sh

while getopts f: flag
do
	case "${flag}" in 
		f) file=${OPTARG};;
	esac
done

echo "Running 5_addRows.sh" 

paste -d, GORows.txt "$file" | tail -n+2 > "$file".named.csv

rm "$file"
