#!/bin/bash

# reads from "sra.txt"

# start a for loop to go through a txt file of SRA numbers and download the fasta files

for i in $(cat sra.txt)
do
echo ${i} > tmp
perl ./sra_download.pl --id ~/.aspera/connect/etc/asperaweb_id_dsa.openssh --ascp tmp
rm tmp

tput setaf 6; echo "------START of assemblertobins run for ${i}------"; tput sgr0

# assemble with megahit

megahit -1 ${i}/${i}_1.fastq.gz -2 ${i}/${i}_2.fastq.gz -t 32 -o ${i}/${i}megahit

# map the .fa file from megahit to the .fasta files with minimap and put in a .sam file

minimap2 -ax sr -t 32 ${i}/${i}megahit/final.contigs.fa ${i}/${i}_1.fastq.gz ${i}/${i}_2.fastq.gz > ${i}/${i}.sam

# sort the .sam file and turn it into a .bam file

samtools view -Sbh -o ${i}/${i}.bam ${i}/${i}.sam

samtools sort -o ${i}/${i}.sorted.bam ${i}/${i}.bam

# Bin with metabat2

cd ./${i}/
runMetaBat.sh -m 1500 ./${i}megahit/final.contigs.fa ./${i}.sorted.bam 
rm ${i}.sam
cd ../

tput setaf 2; echo "------END of assemblertobins run for ${i}------"; tput sgr0

# loop checkM on output bin files

tput setaf 6; echo "------START of checkm run for ${i}------"; tput sgr0

mkdir ./${i}/${i}checkm
checkm lineage_wf -f ./${i}/${i}checkm/checkM_results.txt -t 32 -x fa ./${i}/final.contigs.fa.metabat-bins1500 ./${i}/${i}checkm/checkM_out

tput setaf 2; echo "------END of checkm run for ${i}------"; tput sgr0

done
