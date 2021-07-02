#!/bin/bash

# THIS IS NOT TROUBLESHOOTED TO RUN SMOOTHLY. IT IS A MASH OF CODE BECAUSE IT HAD TO BE USED 
# ACROSS SEVERAL DIFFERENT ENVIRONMENTS ON A REMOTE SERVER. 
# READ WHAT YOU USE CAREFULLY, KEEP AN EYE ON IT AND MAYBE HAVE THE PROGRAM MANUALS AT THE READY

# reads from "sra.txt"

# start a for loop to go through a txt file of SRA numbers and download the fasta files

for i in $(cat sra-for-refine.txt)
do

tput setaf 6; echo "------START of Get Contigs for Refinement for ${i}------"; tput sgr0

# make a refining directory
mkdir ${i}/${i}-refinebin

tput setaf 5; echo "------Blasting ${i} contigs for Rickettsia------"; tput sgr0

#blast megahit final-contig.fa against Rickettsia-DB
blastn -task megablast -query ${i}/*megahit/final.contigs.fa -db Rickettsia-DB -evalue 1e-10 -num_threads 16 -outfmt 6 -out ${i}/${i}-refinebin/${i}-blastn-out

tput setaf 5; echo "------Getting the hit list for ${i}------"; tput sgr0

#retrieve hit list
cut -f1 ${i}/${i}-refinebin/${i}-blastn-out | sort -u > ${i}/${i}-refinebin/${i}-hitlist.txt

tput setaf 3; cat ${i}/${i}-refinebin/${i}-hitlist.txt | wc -l; tput srg0

tput setaf 5; echo "------Extracting ${i} Rickettsia contigs------"; tput sgr0

# perl one liner to extract contigs with the hit list
perl -ne 'if(/^>(\S+)/){$c=$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV'  Round-2-${i}/${i}-refinebin/${i}-hitlist.txt ${i}/*megahit/final.contigs.fa > ${i}/${i}-refinebin/${i}-Rickettsia-contigs.fa

# get contigs between 1000 and 2500 length

cat ${i}/${i}-refinebin/${i}-Rickettsia-contigs.fa | seqkit seq -m 1000 -m 2500 > ${i}/${i}-refinebin/${i}-2500K-contigs.fa

tput setaf 5; echo "------Getting Rickettsia contig coverage ${i}------"; tput sgr0

# get contig coverage from the final.contig.depth.txt file

samtools index ${i}/${i}.sorted.bam
for contig in $(cat ${i}/${i}-refinebin/${i}-hitlist.txt)
do
samtools depth -a -r ${contig} ${i}/${i}.sorted.bam | awk ‘{c++;s+=$3}END{print s/c}’ >> ${i}/${i}-refinebin/${i}-depth.txt
done

# combine the new hitlist and depth file
paste ${i}/${i}-refinebin/${i}-hitlist.txt ${i}/${i}-refinebin/${i}-depth-.txt > ${i}/${i}-refinebin/${i}-contigs-and-depths.txt


tput setaf 2; echo "------END of Get Contigs for Refinement run for ${i}------"; tput sgr0

#blastx final-contig.fa against nr to identify species

tput setaf 5; echo "------Blastx-ing ${i} contigs for Rickettsia------"; tput sgr0

blastx -query ${i}/${i}-refinebin/${i}-new-Rickettsia-contigs.fa -db nr -evalue 1e-3 -num_threads 32 -outfmt "6 qseqid sseqid sscinames pident length evalue bitscore" -out ${i}/${i}-refinebin/${i}-nr-out-FULL.txt


tput setaf 2; echo "------END of blastx-ing ${i} contigs for Rickettsia------"; tput sgr0

# manually look for rickettsia hits in the blastx results and compare this to the average depths of the contigs. All contigs with strong identity and/or similar depths are considered “real” hits
# use the new hit list to extract contigs after manual processing to form a refined bin

perl -ne 'if(/^>(\S+)/){$c=$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV'  ${i}-new-hitlist.txt ${i}/*megahit/final.contigs.fa > All-Refined-Bins/${i}-all-refined-contigs.fa

# make sure copies of original bins are in a new directory with refined small contig files and combine the refined small contigs with the original bin
cd All-Refined-Bins
mkdir final-refined-bins
cat ${i}-all-refined-contigs.fa ${i}-original-bin.fa > ${i}-combined.fa
seqkit rmdup -s -i ${i}-combined.fa -o final-refined-bins/${i}-rmdup.fa

# run checkM on all new bins to look for improvements on the original bins
checkm lineage_wf -f All-refined-bins/refined-bins-checkm/checkM_results.txt -t 32 -x fa All-refined-bins/final-refined-bins refined-bins-checkm/checkM_out


done

