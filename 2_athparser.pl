use strict;
    use Bio::SearchIO;
   
    my $in = new Bio::SearchIO(-format => 'blast', 
                               -file   => "$ARGV[0]");
    while( my $result = $in->next_result ) {
      	while( my $hit = $result->next_hit ) {
			while( my $hsp = $hit->next_hsp ) {	
				if ( $hit->name ne $result->query_name){
			  	if ( $hsp->length('total') >= 100 ){ 
		 		if ( $hsp->expect <= 1e-10){ 
			     	open (OUT, ">>parsed.$ARGV[0]");
					print OUT
		   			"Query=", $result->query_name, 
	      	   		" , Hit=",       $hit->name, 
					" , Description=", $hit->description,"\n";  
	     			close OUT; 
				}
      			}
    			}
     		}
     	}
    }
exit;
