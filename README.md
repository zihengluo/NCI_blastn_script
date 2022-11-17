# NCI_blastn_script

This script is used to do blastn on ONT read data agaisnt a local NCBI nt database. 

It is designed to be used by NCI user of xf3 project. 

All the scripts, database, and test data are placed in /g/data/xf3/blastn_database.

The script to be submitted to NCI is called blastn2.12.sh because it runs blastn v2.12.0. 

The test data can be used for a try are in /g/data/xf3/blastn_database/fastq.

The outputs of blastn on test data are in /g/data/xf3/blastn_database/blast2.12_output.

You can login NCI and run the script for a quick check:

`qsub /g/data/xf3/blastn_database/blastn2.12.sh`
