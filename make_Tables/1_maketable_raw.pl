#############
#
#	Emily Sessa
#	Barker lab, UA EEB
#	Last updated by Jessie Pelosi, Sept 2022
#	University of Florida
#
#	Idea: to take output from encompassing and duplicated gene pipelines and get frequency data for GO categories
#		This will then be used as input for R to make the heatmaps
#	On command line: perl 	maketable_raw.pl	compare_annotations or WGD_file
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

	#print "The length of array1 is $length1\n"; 
	#print "The length of mito is $mito\n";
	#print "The length of ER is $ER\n";


open (OUT, ">rawTable_$file1");
print OUT "GO category, $file1\n";

@table = (
	['abscission', $abscission],
	['anatomical structure development', $anatomical],
	['biosynthetic process', $biosynthesis],
	['carbohydrate binding', $carbbinding],
	['carbohydrate metabolic process', $carbmetab],
	['catabolic process', $catabolic],
	['catalytic activity', $catalytic],
	['cell communication', $cellcomm],
	['cell cycle', $cellcycle],
	['cell death', $celldeath],
	['cell differentiation', $celldiff],
	['cell growth', $cellgrowth],
	['cell wall', $cellwall],
	['cell-cell signaling', $cellsign],
	['cellular component organization', $cellcomp],
	['cellular homeostasis', $cellhomeo],
	['cellular protein modification process', $cellprotein],
	['chloroplast', $chloroplast],
	['chromatin binding', $chromatin],
	['circadian rhythm', $circadian],
	['cytoplasm', $cytoplasm],
	['cytoskeleton', $cytoskeleton],
	['cytosol', $cytosol],
	['DNA binding', $DNAbinding],
	['DNA metabolic process', $DNAmetab],
	['DNA-binding transcription factor activity', $DNATF],
	['embryo development', $embryodev],
	['endoplasmic reticulum', $ER],
	['endosome', $endosome],
	['enzyme regulator activity', $ezymereg],
	['extracellular region', $extracellreg],
	['flower development', $flowerdev],
	['generation of precursor metabolites and energy', $genprecursors],
	['Golgi apparatus', $golgi],
	['growth', $growth],
	['hydrolase activity', $hydrolase],
	['kinase activity', $kinase],
	['lipid binding', $lipidbinding],
	['lipid metabolic process', $lipidmetab],
	['mitochondrion', $mitochondrion],
	['motor activity', $motor],
	['multicellular organism development', $multicelldev],
	['nuclear envelope', $nucenv],
	['nuclease activity', $nucact],
	['nucleic acid binding', $nucbind],
	['nucleobase-containing compound metabolic process', $nucmetab],
	['nucleolus', $nucleolus],
	['nucleoplasm', $nucleoplasm],
	['nucleotide binding', $ntbind],
	['nucleus', $nucleus],
	['other binding', $otherbind],
	['other biological processes', $otherbio],
	['other cellular components', $othercellcomp],
	['other cellular processes', $othercellproc],
	['other intracellular components', $otherincell],
	['other membranes', $othermemb],
	['other metabolic processes', $othermetab],
	['other molecular functions', $othermolecular],
	['oxygen binding', $oxygenbind],
	['peroxisome', $peroxisome],
	['photosynthesis', $photosynthesis],
	['plasma membrane', $plasmamemb],
	['plastid', $plastid],
	['pollination', $pollination],
	['post-embryonic development', $postembryodev],
	['protein binding', $proteinbind],
	['protein metabolic process', $proteinmetab],
	['regulation of gene expression, epigenetic', $reggeneexp],
	['regulation of molecular function', $regmolecfxn],
	['reproduction', $reproduction],
	['response to abiotic stimulus', $respabiotic],
	['response to biotic stimulus', $respbiotic],
	['response to chemical', $respchem],
	['response to endogenous stimulus', $respendo],
	['response to external stimulus', $respext],
	['response to light stimulus', $resplight],
	['response to stress', $respstress],
	['ribosome', $ribosome],
	['RNA binding', $RNAbind],
	['secondary metabolic process', $secmetab],
	['signal transduction', $signtrans],
	['signaling receptor activity', $signrecepact],
	['signaling receptor binding', $signrecepbind],
	['structural molecule activity', $strcmolec],
	['thylakoid', $thylakoid],
	['transcription regulator activity', $TFreg],
	['transferase activity', $transferase],
	['translation', $translation],
	['translation factor activity, RNA binding', $translfactor],
	['transport', $transport],
	['transporter activity', $transportact],
	['tropism', $tropism],
	['unknown biological processes', $unknowbio],
	['unknown cellular components', $unknowcell],
	['unknown molecular functions', $unknowmol],
	['vacuo', $vacuole],
);

for $row (@table) {
	my $join = join(',', @$row),;
	print OUT "$join\n";
	}

close(IN1);
close(OUT);
