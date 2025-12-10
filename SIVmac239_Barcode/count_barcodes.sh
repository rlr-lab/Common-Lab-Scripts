#! /bin/bash

for i in *.fastq.gz; do \
  base=$(basename -s .fastq.gz $i); \
  fastplong -i "${i}" -o "${base}"_fpl.fastq.gz -l 1200 --length_limit 20000 && rm fastplong*; \
  minimap2 -ax lr:hq barcode_reference.fas "${base}"_fpl.fastq.gz > "${base}".sam && rm "${base}"_fpl.fastq.gz; \
  samtools view -bS -F 0x904 "${base}".sam > "${base}".bam && rm "${base}".sam; \
  samtools sort "${base}".bam > "${base}"_sorted.bam && rm "${base}".bam; \
  samtools index "${base}"_sorted.bam; \
  echo "${base}" >> avg_depth.txt; \
  samtools view -c "${base}"_sorted.bam >> avg_depth.txt; \
  samtools depth -a -r "barcode" "${base}"_sorted.bam > "${base}"_depth.txt; \
  perl bam_barcode_count.pl -b "${base}"_sorted.bam -n barcode -s 113 -e 122 > "${base}"_barcodes.txt; \
  done
