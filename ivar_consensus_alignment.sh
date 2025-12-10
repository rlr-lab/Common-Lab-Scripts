#! /bin/bash

# Update file path to appropriate reference
REFERENCE=/file/path

for i in *.fastq.gz; \
  do base=$(basename -s .fastq.gz "${i}"); \
  fastplong -i "${i}" -o "${base}"_cleaned.fastq.gz -l 1200 --length_limit 20000 && rm fastplong*; \
  minimap2 -ax lr:hq "${REFERENCE}" "${base}"_cleaned.fastq.gz > "${base}".sam; \
  samtools view -bS -F 0x904 -h "${base}".sam > "${base}".bam && rm "${base}".sam; \
  samtools sort "${base}".bam > "${base}"_sorted.bam && rm "${base}".bam; \
  samtools mpileup -aa -A -Q 0 "${base}"_sorted.bam | ivar consensus -p "${base}"_con1 -q 10 -m 100 -k; \
  rm "${base}"_sorted.bam; \
  minimap2 -ax lr:hq "${base}"_con1.fa "${base}"_cleaned.fastq.gz > "${base}".sam && rm "${base}"_cleaned.fastq.gz "${base}"_con1*; \
  samtools view -bS -F 0x904 -h "${base}".sam > "${base}".bam && rm "${base}".sam; \
  samtools sort "${base}".bam > "${base}"_sorted.bam && rm "${base}".bam; \
  samtools index "${base}"_sorted.bam; \
  samtools mpileup -aa -A -Q 0 "${base}"_sorted.bam | ivar consensus -p "${base}"_consensus -q 10 -t 0.5 -n N; \
  done
