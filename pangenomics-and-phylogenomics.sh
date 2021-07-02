## script and options used to construct a pangenome in Anvi'o 7 
## full instructions and documentation can be found on the Anvi'o 7 website, so go look there
## this is just a summary of what options were used in this project

for i in $(sra.txt)
do

# reformat fasta
anvi-script-reformat-fasta ${i}.fa -o ${i}-fixed.fa -l 0 --simplify-names

# make a contig database and run all the necessary extra commands to annotate and assign functions
anvi-gen-contigs-database -f ${i}-fixed.fa -o ${i}.db -n '${i} contigs database'
anvi-run-hmms -c ${i}.db
anvi-run-ncbi-cogs -c ${i}.db --num-threads 12
anvi-run-kegg-kofams -c ${i}.db --num-threads 12

# make a list of tab delimited names and paths for the external-genomes-txt

# make the pangenome
anvi-gen-genomes-storage -e external-genomes.txt -o GENOMES.db
anvi-pan-genome -g GENOMES.db \
                --project-name "Rickettsia_Pan" \
                --output-dir RICKETTSIA-PANGENOME/ \
                --num-threads 6 \
                --minbit 0.5 \
                --mcl-inflation 2 \
                --use-ncbi-blast

# add pyANI scores to the pangenome
anvi-compute-genome-similarity -e external-genomes.txt \
                               --program pyANI \
                               --output-dir ANI \
                               --num-threads 6 \
                               -p PAN.db


# examine the pangenome and extract the core gene clusters and clusters for ribosomal proteins
# ribosomal proteins have to be looked through manually with anvi'o but core can be extracted througgh the commandline like this:
anvi-get-sequences-for-gene-clusters -p PAN.db -g GENOMES.db --min-num-genomes-gene-cluster-occurs 104 --max-num-genes-from-each-genome 1 --concatenate-gene-clusters -o core-gene-clusters-amino-acids.fas

## making phylogenetic trees
iqtree -s core-gene-clusters-amino-acids.fas -m MFP -nt AUTO -bb 1000 – alrt 1000
iqtree -s ribosomal-gene-clusters-amino-acids.fas -m MFP -nt AUTO -bb 1000 – alrt 1000

## assessing reticulate evolution
# extract core gene cluster names and functions from anvi’o summary
anvi-summarize -p PANGENOME.db -g GENOMES.db -C DEFAULT
# can also get core cluster names from the fasta file

# get phi score for each cluster
for i in $(cat cluster-names.txt)
do
anvi-get-sequences-for-gene-clusters -p PANGENOME.db -g GENOMES.db -o ${i}.fna --report-DNA-sequences --gene-cluster-id ${i}
muscle -in ${i}.fna -out ${i}-aligned.fna
phi -t D -f ${i}-aligned.fna >> Phi-test-results.txt
done

## networks - nearest neighbour network was make by loading the core ammino acid fasta file into SplitsTree4 and selecting the neighbour net distance network options

## metabolic predictions with anvi'o 7. Output then formated to remove rows that are all zeros and split them by function for use with Pheatmap in R
anvi-esitmate-metabolism -e external-genomes.txt --matrix-format --include-metadata --include-zeros


