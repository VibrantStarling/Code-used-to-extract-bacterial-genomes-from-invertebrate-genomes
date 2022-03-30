<a href="https://zenodo.org/badge/latestdoi/381981751"><img src="https://zenodo.org/badge/381981751.svg" alt="DOI"></a>

# Code-used-to-extract-bacterial-genomes-from-invertebrate-genomes
Here you'll find all the commands used to construct genomes from short read archive sequences in the paper (tba) that were not written out in full for readability.

*Files here are not meant to be one smoothly functioning piece of code as they are a mish mash of several .sh files, R code, and straight up console commands that were used across several environments on a remote server. Do not be suprised if you need to work through them line by line to make them work. In fact, I recommend it.*

### ***You have been warned.***

# What's in each file?
Each file contains code and commentary on what the code should do. I've tried to make it easy to follow as much as I can, but free to contact me if anything isn't explained properly.

* `assembly-and-checkm.sh`  - This file contains the commands used to assemble, map, bin, and quality check resulting metagenomicly assembled genomes. This requires the <a href= "https://github.com/gerthmicha/perlscripts/blob/master/sra_download.pl" style="color:inherit;"> an SRA dowload script </a> written by Michael Gerth. Takes a .txt list of SRA accession numbers to run. Should be mostly fine, but may break at the checkm stage (that bit was added in at a later date from another .sh file and has not been tested all together)

* `refine-bins.sh` - code used to grab contigs between 1000-2500bp, identifiy them, clean them, join them with a copy of the original bacteria bin, and then quality check them. Takes a .txt list of SRA accession numbers to run. This one needs to be worked through manually otherwise it will break.

* `pangenomics-and-phylogenomics.sh` - all code used to construct and analyse the genomes. Includes instrctions for: pangenome construction, phylogenetic analysis, network construction and metabolic prediction. This one needs to be worked through manually otherwise it will break.

* `pheatmap-R-script.R` - R code used to make the metabolic heatmaps from metabolic predictions with pheatmap. Needs a tsv or excel file to run containing metabolic function in the first row followed by columns of pathway completion scores for each bacteria genome. I recommend copy and pasting the code you need.

# Languages and Tools Used

  * OS - <a href="https://www.linux.org/">Linux, Debian 7</a>

  ## Extraction and assembly of genomes
  *  <a href= "https://github.com/gerthmicha/perlscripts/blob/master/sra_download.pl"> sra-download.pl </a> - an SRA dowload script written by Michael Gerth to extract fasta/q files from the European Nucleotide Archive database </a>
  *  <a href="https://github.com/voutcn/megahit"> MEGAHIT v1.2.9</a> - metagenomic NGS assembler
  *  <a href="https://bitbucket.org/berkeleylab/metabat/src/master/"> MetaBAT 2</a> - binning algorithm
  *  <a href="https://github.com/lh3/minimap2minimap2"> minimap2 v2.17-r941 </a> - mapping tool
  *  <a href= "http://www.htslib.org/" > Samtools v1.7<a/> - SAM and BAM file handling software
  *  <a href= "https://github.com/shenwei356/seqkit" > Seqkit</a> - software for fasta manipulation
  *  <a href= "https://ecogenomics.github.io/CheckM/" > CheckM v1.1.3</a> - bacterial genome quality check
  *  <a href= "https://www.ncbi.nlm.nih.gov/books/NBK52640/" > BLAST+ v2.9.0</a> - commandline blast alignment search tool

  ## Pangenome, Network and Phyolgeny construction
  *  <a href="https://merenlab.org/software/anvio/"> Anvi'o v7</a> - pangenome construction and pangenomic analysis tool
  *  <a href="http://www.iqtree.org/">IQ-Tree v2.1.2</a> - phylogeny construction and model finding
  *  <a href="https://uni-tuebingen.de/en/fakultaeten/mathematisch-naturwissenschaftliche-fakultaet/fachbereiche/informatik/lehrstuehle/algorithms-in-bioinformatics/software/splitstree/">SplitsTree 4 </a> - network construction and visualisiation
  *  <a href="http://tree.bio.ed.ac.uk/software/figtree/" > FigTree v1.4.4 </a> - phylogeny visulaisation and editing software
  *  <a href="https://www.maths.otago.ac.nz/~dbryant/software/phimanual.pdf" > PhiPack </a> - Phi score caculator for assessing greticulate evolution
  *  <a href="https://petrov.stanford.edu/software/src/muscle3.6/muscle3.6.html" > MUSCLE v3.6 </a> - Muscle alignment algorithm
  *  <a href=https://github.com/SioStef/panplots > Panplots.R <a/> - pangenome accumulation plot R script used by Stefanos Siozios

  ## Metabolic analysis
  *  <a href="https://merenlab.org/software/anvio/"> Anvi'o v7</a> - metabolic prediction from KEGG pathway estimation 
  *  <a href="https://cran.r-project.org/web/packages/pheatmap/pheatmap.pdf" > Pheatmap 1.0.12 <a/> - pretty heatmap constructor for R

  ## Genome annotation
  *  <a href="https://github.com/tseemann/prokka">PROKKA v1.14.6</a> - whole genome annotation software
  *  <a href = "https://interproscan-docs.readthedocs.io/en/latest/Introduction.html" >Interproscan v5.40-77 </a> - protein function identification, used pfam database
  *  <a href = "https://github.com/UCSC-LoweLab/tRNAscan-SE" > tRNAscan-SE </a> - tRNA scanning software

  ## Diagram annotation
  * <a href="https://inkscape.org/" > Inkscape </a> - vector software, used to annotate figures for clarity and uniform aesthetic


# Where to find me
<p align="left">
<a href="https://twitter.com/helsartandsci" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/twitter.svg" alt="helsartandsci" height="30" width="40" /></a>
</p>
