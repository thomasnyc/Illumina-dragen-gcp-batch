# Illumina DRAGEN Bio-IT Platform on Google Cloud
## User Guide and Documentation

## Purpose of the Guide

The purpose of this document is to provide a guide for our customers to execute DRAGEN genomic sequencing analysis on the Google Cloud Platform.  

## Overview

### Solution Description
DRAGEN on GCP enables Illumina’s DRAGEN Bio-IT Platform to be executed on a state of the art cloud architecture that leverages the power of Field Programmable Gate Arrays (FPGAs) to dramatically accelerate sequence analysis pipelines on GCP.   The FPGA machine instances have been specifically optimized for DRAGEN to maximize performance and optimize for cost for the available DRAGEN pipelines.

The DRAGEN solution provides for the execution of analysis pipelines, or“jobs,” that can be initiated using the Google Batch service invoked from within a customer’s individual GCP project.  The sequencing analysis occurs on servers in Google Cloud’s midwest data center.   The Nimbix JARVICE platform, an industry-leading HPC cloud technology platform performs the orchestration of the data, providing accelerated processing with flexible resource distribution.  The raw sequencing data and analysis output is stored in GCP Storage Buckets. 

Users upload their raw sequencing data to GCS buckets.  Once the data is staged, the user executes their DRAGEN workflows via Google Batch which performs the following:

- Initiates a batch job with a customer project
- Copies or streams the data from the customer’s project to the DRAGEN servers
- Executes the DRAGEN analysis utilizing the FPGA accelerators
- Copies the analysis output files back to the customer’s GCP project in the designated location

The following documentation describes in detail how to execute the flow outlined above.

## Uploading Data
DRAGEN inputs and reference data must be uploaded to the Google Cloud Storage Buckets.  As previously mentioned, an existing bucket may be used, but it must be in the same Project where the Google Batch APIs will be invoked.  

Note the directories where the input and reference data are located as well as the desired location for DRAGEN output files.  These directories are parameters that will need to be passed to Google Batch.  

You may use the script provided to upload sample data into the your specific GCS bucket.

`storage_setup.sh`

### 2 methods included in the script. Please comment out the part is not needed before execution
1. **use storage transfer service** 
It is a single gcloud transfer jobs create command which is going to copy all the sample data including reference to the processing bucket.
 
2. **copy dat from GCP sample bucket to the new bucket manually**
It has all the commands to download data and reference data to local disk first and then upload to the processing bucket.
 
## Create Google Cloud Secrets

You need to provide the following information and store them into the GCP Cloud Secret Manager.

- JARVICE credentials provided during onboarding - Provided by Eviden
 ``` 
   JARVICE_API_USERNAME=
   JARVICE_API_APIKEY=
```
- HMAC keys for using S3 protocol access Google Cloud Storage Bucket 

 HMAC keys need to be created. This can be created from the GCS bucket page:
 Create a new service account which shall be used for accessing the bucket
 Settings - > Interoperatbiliy -> Access keys for service accounts
 create a jey for the service account. One can create access key for default compute service account
```
   S3_ACCESS_KEY=
   S3_SECRET_KEY=
```
- Illumina license string - Provided by Illumina
```
   ILLUMINA_LIC_SERVER=https://
```

Update the script with all the secret information. then run the script:
`create_gcp_secret.sh`
 
 
## Prepare Batch Job - env.sh

You need to update the `env.sh` with the DRAGEN arguments

- Illumina-Dragen versions  
	Currently our system supports different illumina-dragen versions including
	- illumina-dragen_3_7_8n
    - illumina-dragen_3_10_4n
    - illumina-dragen_4_0_3n
    - illumina-dragen_4_2_4n

Update the JARVICE_DRAGEN_APP to the version you need:

`JARVICE_DRAGEN_APP="illumina-dragen_4_0_3n"`

## Launch the Illumina-dragen job

Simply run the command:

`google-batch.sh`

This shall submit the job. 

## Monitoring the job

DRAGEN job logs are available on a per-job basis from Google Batch.  This includes job status changes as well as application-specific messages from the DRAGEN application. 

Customers may use logs to get information that is useful for analyzing jobs. For example, logs can help debug failed jobs. When Cloud Logging is enabled for a job, Cloud Logging generates the following types of logs for you to view:

task logs (batch_task_logs): logs for any data written to the standard output (stdout) and standard error (stderr) streams. To generate task logs for your job, configure your tasks to write data for analysis and debugging to these streams.
agent logs (batch_agent_logs): logs for activities from the Batch service agent. Batch automatically generates these logs for your job.

Cloud Logging only generates logs after a job starts running. To verify if a job has started running, view the details of the job and confirm that the job's state is RUNNING or a later state. If you need to analyze a job that did not generate logs, for example because a job failed before the RUNNING state, view the details of the job using the gcloud CLI or Batch API and check the statusEvents field. Additional documentation on Cloud Logging may be found here.

When the DRAGEN job completes successfully, it will return “DRAGEN finished normally”  in the job logs. You can view the job status in the Batch section too.

## Troubleshooting / Feedback

If you encounter errors while running the jobs in the EAP environment based on the above use case, please submit a request to:

support@nimbix.net  

Please also cc:

1. Jennifer Wemstrom jwemstrom@google.com
2. Sumeet Ranu sumeetranu@google.com
3. Your Google Account Cloud Engineer and FSR

For general feedback and enhancement suggestions, please send an email to:
   - Jennifer Wemstrom jwemstrom@google.com
   - Sumeet Ranu sumeetranu@google.com
   
Copyright 2023 Google. This software is provided as-is, without warranty or representation for any use or purpose. Your use of it is subject to your agreement with Google.  

