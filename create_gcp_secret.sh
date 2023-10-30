#!/bin/bash

# JARVICE credentials provided during onboarding - Provided by Eviden 
JARVICE_API_USERNAME=<jarvice-user-name>
JARVICE_API_APIKEY=<API-key-provided>
# HMAC keys need to be created. This can be created from the GCS bucket page:
# Create a new service account which shall be used for accessing the bucket
# Settings - > Interoperatbiliy -> Access keys for service accounts
# create a jey for the service account. One can create access key for default compute service account
S3_ACCESS_KEY=GOOG1EFCUKL5Vxxxx
S3_SECRET_KEY=jtxxxxxxx
# Illumina license string - This shall be provided by Illumina. 
ILLUMINA_LIC_SERVER=https:///xxxxxxxx
# Google cloud project
PROJECT=service-hpc-project2
# Google Cloud zone used for testing (e.g. us-central1)
ZONE=us-central1

printf "$JARVICE_API_USERNAME" | gcloud secrets create --project $PROJECT "jarviceApiUsername" --data-file=- --replication-policy=user-managed --locations=$ZONE
printf "$JARVICE_API_APIKEY" | gcloud secrets create --project $PROJECT "jarviceApiKey" --data-file=- --replication-policy=user-managed --locations=$ZONE
printf "$S3_ACCESS_KEY" | gcloud secrets create --project $PROJECT "batchS3AccessKey" --data-file=- --replication-policy=user-managed --locations=$ZONE
printf "$S3_SECRET_KEY" | gcloud secrets create --project $PROJECT "batchS3SecretKey" --data-file=- --replication-policy=user-managed --locations=$ZONE
printf "$ILLUMINA_LIC_SERVER" | gcloud secrets create --project $PROJECT "illuminaLicServer" --data-file=- --replication-policy=user-managed --locations=$ZONE
