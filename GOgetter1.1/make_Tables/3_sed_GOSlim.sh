#######################################
## bash 3_sed_GOSlim.sh -f [table_file.csv]
## Written by Jessie Pelosi, University of Florida 
## Purpose: replace commas in GO Slim categories
#######################################

#!/bin/sh 

while getopts f: flag
do
    case "${flag}" in
        f) file=${OPTARG};;
    esac
done

echo "Running 3_sed_tables on $file";

sed -i 's/, RNA binding/ RNA binding/g' $file 
sed -i 's/, epigenetic/ epigenetic/g' $file

