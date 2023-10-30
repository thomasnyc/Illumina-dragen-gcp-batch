#!/bin/bash

# Google Cloud Storage bucket for testing
BUCKET_NAME=jarvice-dragen-batch
# Google Cloud project
PROJECT=service-hpc-project2

# create storage bucket for test
gcloud storage buckets --project $PROJECT create gs://$BUCKET_NAME

#method 1 - use storage trasnfer service

# There is already a public sample data bucket in GCS with reference from Illumina. 
# IAM - give the project-<project-id>@@storage-transfer-service.iam.gserviceaccount.com role: Storage Legacy Bucket Writer
gcloud transfer jobs create gs://thomashk-public-illumina-sample gs://$BUCKET_NAME

# method 2 - copy data from GCP sample bucket to the new bucket manaually:

# get sample fastq files
wget https://storage.googleapis.com/thomashk-public-illumina-sample/HG002.novaseq.pcr-free.35x.R1.fastq.gz
wget https://storage.googleapis.com/thomashk-public-illumina-sample/HG002.novaseq.pcr-free.35x.R2.fastq.gz 

# Downloading Illumina DRAGEN Multigenome Graph Reference - hg38
# https://support.illumina.com/downloads/dragen-reference-genomes-hg38.html

# Reference for DRAGEN v4.2 
#mkdir 4_2_reference && cd 4_2_reference
#wget https://webdata.illumina.com/downloads/software/dragen/references/genome-files/hg38-alt_masked.cnv.graph.hla.rna-9-r3.0-1.tar.gz
#gunzip hg38-alt_masked.cnv.graph.hla.rna-9-r3.0-1.tar.gz
#tar -xvf hg38-alt_masked.cnv.graph.hla.rna-9-r3.0-1.tar
#cd ..
# Reference for DRAGEN v4.0
#mkdir 4_0_reference && cd 4_0_reference
#wget https://webdata.illumina.com/downloads/software/dragen/hg38%2Balt_masked%2Bcnv%2Bgraph%2Bhla%2Brna-8-r2.0-1.run
#./hg38%2Balt_masked%2Bcnv%2Bgraph%2Bhla%2Brna-8-r2.0-1.run
#cd ..
# Reference for DRAGEN v3.10
#mkdir 3_10_reference && cd 3_10_reference
#wget https://webdata.illumina.com/downloads/software/dragen/hg38_alt_masked_graph_v2%2Bcnv%2Bgraph%2Brna-8-1644018559-1.run
#./hg38_alt_masked_graph_v2%2Bcnv%2Bgraph%2Brna-8-1644018559-1.run
#cd ..
# Reference for DRAGEN v3.9
#mkdir 3_9_reference && cd 3_9_reference
#https://webdata.illumina.com/downloads/software/dragen/genomes/hg38_alt_masked%2Bcnv%2Bgraph%2Brna-8-r1.0-1.run
#./hg38_alt_masked%2Bcnv%2Bgraph%2Brna-8-r1.0-1.run
#cd ..
# Reference for DRAGEN v3.7 or older
#mkdir 3_7_reference && cd 3_7_reference
#wget https://s3.amazonaws.com/webdata.illumina.com/downloads/software/dragen/references/genome-files/hg38/hg38_alt_aware%2Bcnv%2Bgraph%2Brna-8-r1.0-0.run
#./hg38_alt_aware%2Bcnv%2Bgraph%2Brna-8-r1.0-0.run
#cd ..

# Downloading the data from local to the GCS bucket:
gcloud storage cp --project $PROJECT HG002.novaseq.pcr-free.35x.R1.fastq.gz gs://$BUCKET_NAME
gcloud storage cp --project $PROJECT HG002.novaseq.pcr-free.35x.R2.fastq.gz gs://$BUCKET_NAME
# select the reference needed and uncomment the line below:
#gcloud storage cp -r --project $PROJECT 4_2_reference gs://$BUCKET_NAME
#gcloud storage cp -r --project $PROJECT 4_0_reference gs://$BUCKET_NAME
#gcloud storage cp -r --project $PROJECT 3_10_reference gs://$BUCKET_NAME
#gcloud storage cp -r --project $PROJECT 3_9_reference gs://$BUCKET_NAME
#gcloud storage cp -r --project $PROJECT 3_7_reference gs://$BUCKET_NAME
