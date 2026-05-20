#! /bin/bash

for i in *.fastq.gz; do \
  base="${i%.fastq.gz}"; \
  fastplong -i $i -o ${base}_filtered.fastq.gz --qualified_quality_phred 15 --length_required 7500; \ # Change minimum length as needed
  seqtk sample ${base}_filtered.fastq.gz 200 > ${base}_sub.fastq; \ # Keep number of sequences low for flye
  flye --nano-hq ${base}_sub.fastq --out-dir ${base}_flye --iterations 5 --no-alt-contigs --genome-size 9500 --threads 4; \ # Change genome size as needed
  medaka_consensus -i ${base}_filtered.fastq.gz -d ${base}_flye/assembly.fasta -o ${base}_medaka -f -x; \
  done
