
export PROJECT_ID=$(gcloud config get-value project)
echo $PROJECT_ID

gcloud builds submit --tag gcr.io/$PROJECT_ID/webapp

gcloud run deploy webapp --image gcr.io/$PROJECT_ID/webapp --platform managed --region=europe-west1 --allow-unauthenticated
