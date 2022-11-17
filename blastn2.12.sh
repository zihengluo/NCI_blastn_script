#!/bin/bash

#PBS -l ncpus=16
#PBS -l mem=100GB
#PBS -l jobfs=1GB
#PBS -q normal
#PBS -P xf3
#PBS -l walltime=30:00
#PBS -l storage=gdata/xf3+scratch/xf3
#PBS -l wd

source /g/data/xf3/miniconda/etc/profile.d/conda.sh
conda activate blast

# convert fastq to fasta and store fasta files in a newly created folder called fasta_out in $PBS_JOBFS
mkdir $PBS_JOBFS/fasta_out
cd /g/data/xf3/blastn_database/fastq/
for fastq in *.fastq;do sed -n '1~4s/^@/>/p;2~4p' $fastq > $PBS_JOBFS/fasta_out/$fastq.fasta;done

# blastn reads against a local nt database
DB=/g/data/xf3/blastn_database/nt
cd $PBS_JOBFS/fasta_out
cp /g/data/xf3/blastn_database/taxdb.btd .
cp /g/data/xf3/blastn_database/taxdb.bti .
for fasta in *.fasta;do  blastn -query $fasta \
-db $DB/nt \
-evalue 0.01 \
-outfmt '6 qseqid sseqid evalue bitscore length pident nident sgi sacc staxids sscinames scomnames sskingdoms' \
-show_gis \
-num_threads 16 \
| sort -k1,1 -k4,4nr | sort -u -k1,1 --merge >$fasta.$(date +%Y%m%d)_NCBI.nt.blastn_output;done

cp *.blastn_output /g/data/xf3/blastn_database/blast2.12_output
