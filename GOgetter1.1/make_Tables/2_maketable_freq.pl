#############
#
#	Emily Sessa
#	Barker lab, UA EEB
#
#	Idea: to take output from encompassing and duplicated gene pipelines and get frequency data for GO categories
#		This will then be used as input for R to make the heatmaps
#	On command line: perl 	maketable_freq.pl	compare_annotations or WGD_file
#
#############

$file1 = $ARGV[0];

open (IN1, $file1);

$length1 = 0;
	$abscission = 0;
	$anatomical = 0;
	$biosynthesis = 0;
	$carbbinding = 0;
	$carbmetab = 0;
	$catabolic = 0;
	$catalytic = 0;
	$cellcomm = 0;
	$cellcycle = 0;
	$celldeath = 0;
	$celldiff = 0;
	$cellgrowth = 0;
	$cellwall = 0;
	$cellsign = 0;
	$cellcomp = 0;
	$cellhomeo = 0;
	$cellprotein = 0;
	$chloroplast = 0;
	$chromatin = 0;
	$circadian = 0;
	$cytoplasm = 0;
	$cystoskeleton = 0;
	$cytosol = 0;
	$DNAbinding = 0;
	$DNAmetab = 0;
	$DNATF = 0;
	$embryodev = 0;
	$ER = 0;
	$endosome = 0;
	$enzymereg = 0;
	$extracellreg = 0;
	$flowerdev = 0;
	$genprecursors = 0;
	$golgi = 0;
	$growth = 0;
	$hydrolase = 0;
	$kinase = 0;
	$lipidbinding = 0;
	$lipidmetab = 0;
	$mitochondrion = 0;
	$motor = 0;
	$multicelldev = 0;
	$nucenv = 0;
	$nucact = 0;
	$nucbind=0;
	$nucmetab=0;
	$nucleolus=0;
	$nucleoplasm=0;
	$ntbind=0;
	$nucleus=0;
	$otherbind=0;
	$otherbio=0;
	$othercellcomp=0;
	$othercellproc=0;
	$otherincell=0;
	$othermemb=0;
	$othermetab=0;
	$othermolecular=0;
	$oxygenbind=0;
	$peroxisome=0;
	$photosynthesis=0;
	$plasmamemb=0;
	$plastid=0; 
	$pollination=0;
	$postembryodev=0;
	$proteinbind=0;
	$proteinmetab=0;
	$reggeneexp=0;
	$regmolecfxn=0;
	$reproduction=0;
	$respabiotic=0;
	$respbiotic=0;
	$respchem=0;
	$respendo=0;
	$respext=0;
	$resplight=0;
	$respstress=0;
	$ribosome=0; 
	$RNAbind=0;
	$secmetab=0;
	$signtrans=0;
	$signrecepact=0;
	$signrecepbind=0;
	$strcmolec=0;
	$thylakoid=0;
	$TFreg=0;
	$transferase=0;
	$translation=0;
	$translfactor=0;
	$transport=0;
	$transportact=0;
	$tropism=0;
	$unknowbio=0;
	$unknowcell=0;
	$unknowmol=0;
	$vacuole=0; 

while (<IN1>) {
	chomp();
	push @array1, $_;
	@array1 = split/\t/;
	$length1 = $length1+1;
	if ($array1[1] =~ m/abscission/) {$abscission = $abscission+1} 
	if ($array1[1] =~ m/anatomical structure development/) {$anatomical = $anatomical+1} 
	if ($array1[1] =~ m/biosynthetic process/) {$biosynthesis = $biosynthesis+1}	
	if ($array1[1] =~ m/carbohydrate binding/) {$carbbinding = $carbbinding+1} 
	if ($array1[1] =~ m/carbohydrate metabolic process/) {$carbmetab = $carbmetab+1} 
	if ($array1[1] =~ m/catabolic process/) {$catabolic = $catabolic+1} 
	if ($array1[1] =~ m/catalytic activity/) {$catalytic = $catalytic+1} 
	if ($array1[1] =~ m/cell communication/) {$cellcomm = $cellcomm+1} 
	if ($array1[1] =~ m/cell cycle/) {$cellcycle = $cellcycle+1}
	if ($array1[1] =~ m/cell death/) {$celldeath = $celldeath+1}
	if ($array1[1] =~ m/cell differentiation/) {$celldiff = $celldiff+1}
	if ($array1[1] =~ m/cell growth/) {$cellgrowth = $cellgrowth+1}
	if ($array1[1] =~ m/cell wall/) {$cellwall = $cellwall+1}
	if ($array1[1] =~ m/cell-cell signaling/) {$cellsign = $cellsign+1}	
	if ($array1[1] =~ m/cellular component organization/) {$cellcomp = $cellcomp+1}
	if ($array1[1] =~ m/cellular homeostasis/) {$cellhomeo = $cellhomeo+1}
	if ($array1[1] =~ m/cellular protein modification process/) {$cellprotein = $cellprotein+1}
	if ($array1[1] =~ m/chloroplast/) {$chloroplast = $chloroplast+1}
	if ($array1[1] =~ m/chromatin binding/) {$chromatin = $chromatin+1}
	if ($array1[1] =~ m/circadian rhythm/) {$circadian = $circadian+1}
	if ($array1[1] =~ m/cytoplasm/) {$cytoplasm = $cytoplasm+1}
	if ($array1[1] =~ m/cytoskeleton/) {$cytoskeleton = $cytoskeleton+1}
	if ($array1[1] =~ m/cytosol/) {$cytosol = $cytosol+1}
	if ($array1[1] =~ m/DNA binding/) {$DNAbinding = $DNAbinding+1}
	if ($array1[1] =~ m/DNA metabolic process/) {$DNAmetab = $DNAmetab+1}
	if ($array1[1] =~ m/DNA-binding transcription factor activity/) {$DNATF = $DNATF+1}
	if ($array1[1] =~ m/embryo development/) {$embryodev = $embryodev+1}
	if ($array1[1] =~ m/endoplasmic reticulum/) {$ER = $ER+1}
	if ($array1[1] =~ m/endosome/) {$endosome = $endosome+1}
	if ($array1[1] =~ m/enzyme regulator activity/) {$ezymereg = $ezymereg+1}
	if ($array1[1] =~ m/extracellular region/) {$extracellreg = $extracellreg+1}
	if ($array1[1] =~ m/flower development/) {$flowerdev = $flowerdev+1}
	if ($array1[1] =~ m/generation of precursor metabolites and energy/) {$genprecursors = $genprecursors+1}
	if ($array1[1] =~ m/Golgi apparatus/) {$golgi = $golgi+1}
	if ($array1[1] =~ m/growth/) {$growth = $growth+1}
	if ($array1[1] =~ m/hydrolase activity/) {$hydrolase = $hydrolase+1}
	if ($array1[1] =~ m/kinase activity/) {$kinase = $kinase+1}
	if ($array1[1] =~ m/lipid binding/) {$lipidbinding = $lipidbinding+1}
	if ($array1[1] =~ m/lipid metabolic process/) {$lipidmetab = $lipidmetab+1}
	if ($array1[1] =~ m/mitochondrion/) {$mitochondrion = $mitochondrion+1}
	if ($array1[1] =~ m/motor activity/) {$motor = $motor+1}
	if ($array1[1] =~ m/multicellular organism development/) {$multicelldev = $multicelldev+1}
	if ($array1[1] =~ m/nuclear envelope/) {$nucenv = $nucenv+1}
	if ($array1[1] =~ m/nuclease activity/) {$nucact = $nucact+1}
	if ($array1[1] =~ m/nucleic acid binding/) {$nucbind = $nucbind+1}
	if ($array1[1] =~ m/nucleobase-containing compound metabolic process/) {$nucmetab = $nucmetab+1}
	if ($array1[1] =~ m/nucleolus/) {$nucleolus = $nucleolus+1}
	if ($array1[1] =~ m/nucleoplasm/) {$nucleoplasm = $nucleoplasm+1}
	if ($array1[1] =~ m/nucleotide binding/) {$ntbind = $ntbind+1}
	if ($array1[1] =~ m/nucleus/) {$nucleus = $nucleus+1}
	if ($array1[1] =~ m/other binding/) {$otherbind = $otherbind+1}
	if ($array1[1] =~ m/other biological processes/) {$otherbio = $otherbio+1}
	if ($array1[1] =~ m/other cellular components/) {$othercellcomp = $othercellcomp+1}
	if ($array1[1] =~ m/other cellular processes/) {$othercellproc = $othercellproc+1}
	if ($array1[1] =~ m/other intracellular components/) {$otherincell = $otherincell+1}
	if ($array1[1] =~ m/other membranes/) {$othermemb = $othermemb+1}
	if ($array1[1] =~ m/other metabolic processes/) {$othermetab = $othermetab+1}
	if ($array1[1] =~ m/other molecular functions/) {$othermolecular = $othermolecular+1}
	if ($array1[1] =~ m/oxygen binding/) {$oxygenbind = $oxygenbind+1}
	if ($array1[1] =~ m/peroxisome/) {$peroxisome = $peroxisome+1}
	if ($array1[1] =~ m/photosynthesis/) {$photosynthesis = $photosynthesis+1}
	if ($array1[1] =~ m/plasma membrane/) {$plasmamemb = $plasmamemb+1}
	if ($array1[1] =~ m/plastid/) {$plastid = $plastid+1}
	if ($array1[1] =~ m/pollination/) {$pollination = $pollination+1}
	if ($array1[1] =~ m/post-embryonic development/) {$postembryodev = $postembryodev+1}
	if ($array1[1] =~ m/protein binding/) {$proteinbind = $proteinbind+1}
	if ($array1[1] =~ m/protein metabolic process/) {$proteinmetab = $proteinmetab+1}
	if ($array1[1] =~ m/regulation of gene expression, epigenetic/) {$reggeneexp = $reggeneexp+1}
	if ($array1[1] =~ m/regulation of molecular function/) {$regmolecfxn = $regmolecfxn+1}
	if ($array1[1] =~ m/reproduction/) {$reproduction = $reproduction+1}
	if ($array1[1] =~ m/response to abiotic stimulus/) {$respabiotic = $respabiotic+1}
	if ($array1[1] =~ m/response to biotic stimulus/) {$respbiotic = $respbiotic+1}
	if ($array1[1] =~ m/response to chemical/) {$respchem = $respchem+1}
	if ($array1[1] =~ m/response to endogenous stimulus/) {$respendo = $respendo+1}
	if ($array1[1] =~ m/response to external stimulus/) {$respext = $respext+1}
	if ($array1[1] =~ m/response to light stimulus/) {$resplight = $resplight+1}
	if ($array1[1] =~ m/response to stress/) {$respstress = $respstress+1}
	if ($array1[1] =~ m/ribosome/) {$ribosome = $ribosome+1}
	if ($array1[1] =~ m/RNA binding/) {$RNAbind = $RNAbind+1}
	if ($array1[1] =~ m/secondary metabolic process/) {$secmetab = $secmetab+1}
	if ($array1[1] =~ m/signal transduction/) {$signtrans = $signtrans+1}
	if ($array1[1] =~ m/signaling receptor activity/) {$signrecepact = $signrecepact+1}
	if ($array1[1] =~ m/signaling receptor binding/) {$signrecepbind = $signrecepbind+1}
	if ($array1[1] =~ m/structural molecule activity/) {$strcmolec = $strcmolec+1}
	if ($array1[1] =~ m/thylakoid/) {$thylakoid = $thylakoid+1}
	if ($array1[1] =~ m/transcription regulator activity/) {$TFreg = $TFreg+1}
	if ($array1[1] =~ m/transferase activity/) {$transferase = $transferase+1}
	if ($array1[1] =~ m/translation/) {$translation = $translation+1}
	if ($array1[1] =~ m/translation factor activity, RNA binding/) {$translfactor = $translfactor+1}
	if ($array1[1] =~ m/transport/) {$transport = $transport+1}
	if ($array1[1] =~ m/transporter activity/) {$transportact = $transportact+1}
	if ($array1[1] =~ m/tropism/) {$tropism = $tropism+1}
	if ($array1[1] =~ m/unknown biological processes/) {$unknowbio = $unknowbio+1}
	if ($array1[1] =~ m/unknown cellular components/) {$unknowcell = $unknowcell+1}
	if ($array1[1] =~ m/unknown molecular functions/) {$unknowmol = $unknowmol+1}
	if ($array1[1] =~ m/vacuole/) {$vacuole = $vacuole+1}
}		


open (OUT, ">freqTable_$file1");
print OUT "GO category, $file1\n";

@table = (
	['abscission', $abscission/$length1*100],
	['anatomical structure development', $anatomical/$length1*100],
	['biosynthetic process', $biosynthesis/$length1*100],
	['carbohydrate binding', $carbbinding/$length1*100],
	['carbohydrate metabolic process', $carbmetab/$length1*100],
	['catabolic process', $catabolic/$length1*100],
	['catalytic activity', $catalytic/$length1*100],
	['cell communication', $cellcomm/$length1*100],
	['cell cycle', $cellcycle/$length1*100],
	['cell death', $celldeath/$length1*100],
	['cell differentiation', $celldiff/$length1*100],
	['cell growth', $cellgrowth/$length1*100],
	['cell wall', $cellwall/$length1*100],
	['cell-cell signaling', $cellsign/$length1*100],
	['cellular component organization', $cellcomp/$length1*100],
	['cellular homeostasis', $cellhomeo/$length1*100],
	['cellular protein modification process', $cellprotein/$length1*100],
	['chloroplast', $chloroplast/$length1*100],
	['chromatin binding', $chromatin/$length1*100],
	['circadian rhythm', $circadian/$length1*100],
	['cytoplasm', $cytoplasm/$length1*100],
	['cytoskeleton', $cytoskeleton/$length1*100],
	['cytosol', $cytosol/$length1*100],
	['DNA binding', $DNAbinding/$length1*100],
	['DNA metabolic process', $DNAmetab/$length1*100],
	['DNA-binding transcription factor activity', $DNATF/$length1*100],
	['embryo development', $embryodev/$length1*100],
	['endoplasmic reticulum', $ER/$length1*100],
	['endosome', $endosome/$length1*100],
	['enzyme regulator activity', $ezymereg/$length1*100],
	['extracellular region', $extracellreg/$length1*100],
	['flower development', $flowerdev/$length1*100],
	['generation of precursor metabolites and energy', $genprecursors/$length1*100],
	['Golgi apparatus', $golgi/$length1*100],
	['growth', $growth/$length1*100],
	['hydrolase activity', $hydrolase/$length1*100],
	['kinase activity', $kinase/$length1*100],
	['lipid binding', $lipidbinding/$length1*100],
	['lipid metabolic process', $lipidmetab/$length1*100],
	['mitochondrion', $mitochondrion/$length1*100],
	['motor activity', $motor/$length1*100],
	['multicellular organism development', $multicelldev/$length1*100],
	['nuclear envelope', $nucenv/$length1*100],
	['nuclease activity', $nucact/$length1*100],
	['nucleic acid binding', $nucbind/$length1*100],
	['nucleobase-containing compound metabolic process', $nucmetab/$length1*100],
	['nucleolus', $nucleolus/$length1*100],
	['nucleoplasm', $nucleoplasm/$length1*100],
	['nucleotide binding', $ntbind/$length1*100],
	['nucleus', $nucleus/$length1*100],
	['other binding', $otherbind/$length1*100],
	['other biological processes', $otherbio/$length1*100],
	['other cellular components', $othercellcomp/$length1*100],
	['other cellular processes', $othercellproc/$length1*100],
	['other intracellular components', $otherincell/$length1*100],
	['other membranes', $othermemb/$length1*100],
	['other metabolic processes', $othermetab/$length1*100],
	['other molecular functions', $othermolecular/$length1*100],
	['oxygen binding', $oxygenbind/$length1*100],
	['peroxisome', $peroxisome/$length1*100],
	['photosynthesis', $photosynthesis/$length1*100],
	['plasma membrane', $plasmamemb/$length1*100],
	['plastid', $plastid/$length1*100],
	['pollination', $pollination/$length1*100],
	['post-embryonic development', $postembryodev/$length1*100],
	['protein binding', $proteinbind/$length1*100],
	['protein metabolic process', $proteinmetab/$length1*100],
	['regulation of gene expression, epigenetic', $reggeneexp/$length1*100],
	['regulation of molecular function', $regmolecfxn/$length1*100],
	['reproduction', $reproduction/$length1*100],
	['response to abiotic stimulus', $respabiotic/$length1*100],
	['response to biotic stimulus', $respbiotic/$length1*100],
	['response to chemical', $respchem/$length1*100],
	['response to endogenous stimulus', $respendo/$length1*100],
	['response to external stimulus', $respext/$length1*100],
	['response to light stimulus', $resplight/$length1*100],
	['response to stress', $respstress/$length1*100],
	['ribosome', $ribosome/$length1*100],
	['RNA binding', $RNAbind/$length1*100],
	['secondary metabolic process', $secmetab/$length1*100],
	['signal transduction', $signtrans/$length1*100],
	['signaling receptor activity', $signrecepact/$length1*100],
	['signaling receptor binding', $signrecepbind/$length1*100],
	['structural molecule activity', $strcmolec/$length1*100],
	['thylakoid', $thylakoid/$length1*100],
	['transcription regulator activity', $TFreg/$length1*100],
	['transferase activity', $transferase/$length1*100],
	['translation', $translation/$length1*100],
	['translation factor activity, RNA binding', $translfactor/$length1*100],
	['transport', $transport/$length1*100],
	['transporter activity', $transportact/$length1*100],
	['tropism', $tropism/$length1*100],
	['unknown biological processes', $unknowbio/$length1*100],
	['unknown cellular components', $unknowcell/$length1*100],
	['unknown molecular functions', $unknowmol/$length1*100],
	['vacuole', $vacuole/$length1*100],
	);

for $row (@table) {
	my $join = join(',', @$row),;
	print OUT "$join\n";
	}

close(IN1);
close(OUT);

