#############
#
#	Emily Sessa, Aug 2012
#	Barker lab, UA EEB
#
#	This program reads text data files in a directory, selects one column, and merges the data into one file.
#
# 	On command line: perl 	make_csv.pl		freq_tables OR raw_tables  	1	outfilename
#
#############


$delimiter = "\,";	#delimiter: "comma delimited"

$dir = @ARGV[0]; 	#input name of the data directory from command line 
$columnNo = @ARGV[1];	#input number of the column to be read from command line. 0 for the first column, 1 for second
$outfile = @ARGV[2];	#input name of the output file from command line

#remind user there is no input data directory or column number
if(!$dir or (!$columnNo && $columnNo ne '0') ) {
  print "No input data directory or column number.\nUsage: perl my_perl.pl dir columnNo outfile\n";
}

#read the directory 
opendir(DIR, $dir) or die "can not open directory $dir\n";

 while($name = readdir(DIR)) {
   #save data file names in an array, don't include . and .. 
   push(@files, $name) if( !($name eq '.' || $name eq '..') );
 }

closedir(DIR) or  die "can not close directory $dir\n";

#process data
if($dir && ($columnNo || $columnNo eq '0') ) {
  
  #read files
  for($i = 0; $i < @files; $i++) {
    $infile = $dir.'/'.@files[$i];
    
    #each individual file
    open(IN, $infile) or die "can not open $infile\n";

      #row number, 0 for first row. Reset for each file
      $rowNo = 0;

      #read the file
      while( $line = <IN> ) {
     
       # get rid of the new line character, otherwise data in the last column incorrect
       chomp($line);

       # split to put data in each row into an array
       @data = split(/$delimiter/, $line);
       
       # remember data in a "matrix".
       $datamatrix{$i, $rowNo} = @data[$columnNo];

       # add 1 to row number
       $rowNo++;
      }

    close(IN) or die "can not close $infile\n";

   }
}

# print results. If output file name provided print to output file, else to screen
if($outfile) {
  open (OUT, ">$outfile") or die "can not open $outfile\n";

  # first row file names
  for($i = 0; $i < @files; $i++) {
     print OUT @files[$i];
     print OUT "\t" if($i < @files -1);
  }
  print OUT "\n";

  # data 
  for($j = 0; $j < $rowNo; $j++) {
   for($i = 0; $i < @files; $i++) {
     print OUT $datamatrix{$i, $j};
     print OUT "\t" if($i < @files -1);
   }
     print OUT "\n";
  }

  close(OUT) or die "can not close $outfile\n";   
}
else {
  # first row file names
  for($i = 0; $i < @files; $i++) {
     print @files[$i];
     print "\t" if($i < @files -1);
  }
  print "\n";

  # data 
  for($j = 0; $j < $rowNo; $j++) {
   for($i = 0; $i < @files; $i++) {
     print $datamatrix{$i, $j};
     print "\t" if($i < @files -1);
   }
     print "\n";
  }
}
