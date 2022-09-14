#!/bin/perl

$file = $ARGV[0];
print("Parsing $file\n");

open(IN, $file);
my %seen;
my @rank;
while(<IN>){
  chomp();
  $line = $_;
  my @tmp = split(/\=/, $line, 2);
  $ctg = $tmp[0];
  
  if($ctg =~ /x\d+x/g){ #I add a REGEXP here to keep only lines having the YY###ZZ scheme
    if($seen{$ctg}){
      print("skip $ctg\n");
      } else {
      $seen{$ctg} = $line;
      print("New contig, saving first of $ctg\n");
      push(@rank, $ctg);
      }
    }
  }
close(IN);

print("Producing output\n");
open(OUT, ">BEST_$file");
# foreach $k (sort(keys(%seen))){ # do this for parsing all the hash keys, but will be done randomly
foreach $k (@rank){ # I use the @rank trick to keep the original sorting
  $best = $seen{$k};
  print(OUT "$best\n");
  }
close(OUT);

