#modify user access to submit script
chmod u+x devops-pipeline.sh

#active account 
gcloud auth list

#project ID
gcloud config list project

#export project ID - environment variable 
export PROJECT_ID=$(gcloud config get-value project)

# create a repo in Artifact Registry 
gcloud artifacts repositories create example-docker-repo --repository-format=docker \
    --location=$Region --description="Docker repository" \
    --project=$PROJECT_ID

# Run the following command to verify that your repository was created
gcloud artifacts repositories list \
    --project=$PROJECT_ID

#set up authentication to Docker repositories in the region $location
gcloud auth configure-docker europe-west1-docker.pkg.dev

#pull the docker image from  public repo
docker pull us-docker.pkg.dev/google-samples/containers/gke/hello-app:1.0

#run the command to tag the image in docker local
docker tag us-docker.pkg.dev/google-samples/containers/gke/hello-app:1.0 \
europe-west1-docker.pkg.dev/$PROJECT_ID/example-docker-repo/sample-image:tag1

#push the image to registry 
docker push europe-west1-docker.pkg.dev/$PROJECT_ID/example-docker-repo/sample-image:tag1



