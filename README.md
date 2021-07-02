# Code-used-to-extract-bacterial-genomes-from-invertebrate-genomes
Here you'll find all the commands used to construct genomes from short read archive sequences in the paper (tba). 

*Most files here are not meant to be one smoothly functioning piece of code as they are a mish mash of several .sh files, R code, python, and straight up console commands that were used across several environments on a remote server. Do not be suprised if you need to work through them line by line to make them work. This may be fixed in the future, but no promises*

***You have been warned.***

# What's in each file?
* `assembly-and-checkm.sh`  - This file contains the commands used to assemble, map, bin, and quality check resulting metagenomicly assembled genomes 

* `refine-bins.sh` - code used to grab contigs between 1000-2500 base, identifiy them, clean them, join them with a copy of the original bacteria bin, and then quality check them.

* `sra-dowload.pl` - pre-written perl script for mass downloading sequences by SRA number from the European Nucleotide Archive that is used within `assembly-checkm.sh` . This one should run smoothly out of the box because it was written to.

* `pangenomics-and-phylogenomics.sh` - all code used to construct and analyse the genomes. Includes instrctions for: pangenome construction, phylogenetic analysis, network construction and metabolic prediction.

* `pheatmap-R-script.R` - R code used to make the metabolic heatmaps from metabolic predictions

# Languages and Tools Used

<p>OS - <a href="https://www.linux.org/">Linux, Debian 7</a> </p>

  ## Extraction and assembly of genomes
  <p>&#9659 <a href="https://github.com/voutcn/megahit"> MEGAHIT v1.2.9</a> - metagenomic NGS assembler</p> 
  <p>&#9659 <a href="https://bitbucket.org/berkeleylab/metabat/src/master/"> MetaBAT 2</a> - binning algorithm</p>
  <p>&#9659 <a href="https://github.com/lh3/minimap2minimap2"> minimap2 v2.17-r941 </a> - mapping tool</p>
  <p>&#9659 <a href= "http://www.htslib.org/" > Samtools v1.7<a/> - SAM and BAM file handling software</p>
  <p>&#9659 <a href= "https://github.com/shenwei356/seqkit" > Seqkit</a> - software for fasta manipulation </p>
  <p>&#9659 <a href= "https://ecogenomics.github.io/CheckM/" > CheckM v1.1.3</a> - bacterial genome quality check</p>
  <p>&#9659 <a href= "https://www.ncbi.nlm.nih.gov/books/NBK52640/" > BLAST+ v2.9.0</a> - commandline blast alignment search tool</p>

  ## Pangenome, Network and Phyolgeny construction
  <p>&#9659 <a href="https://merenlab.org/software/anvio/"> Anvi'o v7</a> - pangenome construction and pangenomic analysis tool </p>
  <p>&#9659 <a href="http://www.iqtree.org/">IQ-Tree v2.1.2</a> phylogeny construction and model finding</p>
  <p>&#9659 <a href="https://uni-tuebingen.de/en/fakultaeten/mathematisch-naturwissenschaftliche-fakultaet/fachbereiche/informatik/lehrstuehle/algorithms-in-bioinformatics/software/splitstree/">SplitsTree 4 </a> - network construction and visualisiation</p>
  <p>&#9659 <a href="http://tree.bio.ed.ac.uk/software/figtree/" > FigTree v1.4.4 </a> - phylogeny visulaisation and editing software</p>
  <p>&#9659 <a href="https://www.maths.otago.ac.nz/~dbryant/software/phimanual.pdf" > PhiPack </a> - Phi score caculator for assessing greticulate evolution</p>
  <p>&#9659 <a href="https://petrov.stanford.edu/software/src/muscle3.6/muscle3.6.html" > MUSCLE v3.6 </a> - Muscle alignment algorithm</p>

  ## Metabolic analysis
  <p>&#9659 <a href = "https://github.com/UCSC-LoweLab/tRNAscan-SE" > tRNAscan-SE </a> - tRNA scanning software</p>
  <p>&#9659 <a href="https://merenlab.org/software/anvio/"> Anvi'o v7</a> - metabolic prediction from KEGG pathway estimation </p>
  <p>&#9659 <a href="https://cran.r-project.org/web/packages/pheatmap/pheatmap.pdf" > Pheatmap 1.0.12 <a/> - pretty heatmap constructor for R</p>

  ## Genome annotation
  <p>&#9659 <a href="https://github.com/tseemann/prokka">PROKKA v1.14.6</a> - whole genome annotation softwarer</p>
  <p>&#9659 <a href = "https://interproscan-docs.readthedocs.io/en/latest/Introduction.html" >Interproscan v5.40-77 </a> - protein function identification, used pfam database </p>

  ## Diagram annotation
  <p>&#9659 <a href="https://inkscape.org/" > Inkscape </a> - vector software, used to annotate figures for clarity and uniform aesthetic



# Where to find me
<p align="left">
<a href="https://twitter.com/helsartandsci" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/twitter.svg" alt="helsartandsci" height="30" width="40" /></a>
</p>
