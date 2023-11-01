# Launching the Illumina-DRAGEN job with native batch submission

Based on the storage and secret manager setup. It is simple to use single JSON file to config. 

- Just update the json file provided:
`batchsubmit.json`

- Use the gcloud command to submit the DRAGEN job. The job name has to be unique in the GCP project
`gcloud batch jobs submit illuminatest-date-1 --location us-central1 --config batchsubmit.json`
