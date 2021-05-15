SHELL := /bin/bash

<<<<<<< HEAD
all: sales-api metrics

keys:
	GO111MODULE=on go run -mod=vendor ./cmd/sales-admin/main.go keygen private.pem

admin:
	GO111MODULE=on go run -mod=vendor ./cmd/sales-admin/main.go --db-disable-tls=1 useradd admin@example.com gophers

migrate:
	GO111MODULE=on go run -mod=vendor ./cmd/sales-admin/main.go --db-disable-tls=1 migrate

seed: migrate
	GO111MODULE=on go run -mod=vendor ./cmd/sales-admin/main.go --db-disable-tls=1 seed

sales-api:
	docker build \
		-f dockerfile.sales-api \
		-t gcr.io/ardan-starter-kit/sales-api-amd64:1.0 \
		--build-arg PACKAGE_NAME=sales-api \
		--build-arg VCS_REF=`git rev-parse HEAD` \
		--build-arg BUILD_DATE=`date -u +”%Y-%m-%dT%H:%M:%SZ”` \
		.
	docker system prune -f

metrics:
	docker build \
		-f dockerfile.metrics \
		-t gcr.io/ardan-starter-kit/metrics-amd64:1.0 \
		--build-arg PACKAGE_NAME=metrics \
		--build-arg PACKAGE_PREFIX=sidecar/ \
		--build-arg VCS_REF=`git rev-parse HEAD` \
		--build-arg BUILD_DATE=`date -u +”%Y-%m-%dT%H:%M:%SZ”` \
		.
	docker system prune -f

up:
	docker-compose up

down:
	docker-compose down

test:
	cd "$$GOPATH/src/github.com/ardanlabs/service"
	GO111MODULE=on go test -mod=vendor ./...

clean:
	docker system prune -f

stop-all:
	docker stop $(docker ps -aq)

remove-all:
	docker rm $(docker ps -aq)

#===============================================================================
# GKE

config:
	@echo Setting environment for ardan-starter-kit
	gcloud config set project ardan-starter-kit
	gcloud config set compute/zone us-central1-b
	gcloud auth configure-docker
	@echo ======================================================================

project:
	gcloud projects create ardan-starter-kit
	gcloud beta billing projects link ardan-starter-kit --billing-account=$(ACCOUNT_ID)
	gcloud services enable container.googleapis.com
	@echo ======================================================================

cluster:
	gcloud container clusters create ardan-starter-cluster --enable-ip-alias --num-nodes=2 --machine-type=n1-standard-2
	gcloud compute instances list
	@echo ======================================================================

upload:
	docker push gcr.io/ardan-starter-kit/sales-api-amd64:1.0
	docker push gcr.io/ardan-starter-kit/metrics-amd64:1.0
	@echo ======================================================================

network:
	# Creating your own VPC network. We will use the default VPC.
	gcloud compute networks create ardan-starter-vpc --subnet-mode=auto --bgp-routing-mode=regional
	gcloud compute addresses create ardan-starter-network --global --purpose=VPC_PEERING --prefix-length=16 --network=ardan-starter-vpc
	gcloud compute addresses list --global --filter="purpose=VPC_PEERING"
	@echo ======================================================================

database:
	gcloud beta sql instances create ardan-starter-db --database-version=POSTGRES_9_6 --no-backup --tier=db-f1-micro --zone=us-central1-b --no-assign-ip --network=default
	gcloud sql instances describe ardan-starter-db
	@echo ======================================================================

db-assign-ip:
	gcloud sql instances patch ardan-starter-db --authorized-networks=[YOUR_IP/32]
	gcloud sql instances describe ardan-starter-db
	@echo ======================================================================

services:
	# Make sure the deploy script has the right IP address for the DB.
	kubectl create -f gke-deploy-sales-api.yaml
	kubectl expose -f gke-expose-sales-api.yaml --type=LoadBalancer
	@echo ======================================================================

status:
=======
export PROJECT = ardan-starter-kit

# ==============================================================================
# Testing running system

# For testing a simple query on the system. Don't forget to `make seed` first.
# curl --user "admin@example.com:gophers" http://localhost:3000/v1/users/token/54bb2165-71e1-41a6-af3e-7da4a0e1e2c1
# export TOKEN="COPY TOKEN STRING FROM LAST CALL"
# curl -H "Authorization: Bearer ${TOKEN}" http://localhost:3000/v1/users/1/2

# For testing load on the service.
# hey -m GET -c 100 -n 10000 -H "Authorization: Bearer ${TOKEN}" http://localhost:3000/v1/users/1/2
# zipkin: http://localhost:9411
# expvarmon -ports=":4000" -vars="build,requests,goroutines,errors,mem:memstats.Alloc"

# Used to install expvarmon program for metrics dashboard.
# go install github.com/divan/expvarmon@latest

# // To generate a private/public key PEM file.
# openssl genpkey -algorithm RSA -out private.pem -pkeyopt rsa_keygen_bits:2048
# openssl rsa -pubout -in private.pem -out public.pem
# ./sales-admin genkey

# ==============================================================================
# Building containers

all: sales metrics

sales:
	docker build \
		-f zarf/docker/dockerfile.sales-api \
		-t sales-api-amd64:1.0 \
		--build-arg VCS_REF=`git rev-parse HEAD` \
		--build-arg BUILD_DATE=`date -u +”%Y-%m-%dT%H:%M:%SZ”` \
		.

metrics:
	docker build \
		-f zarf/docker/dockerfile.metrics \
		-t metrics-amd64:1.0 \
		--build-arg VCS_REF=`git rev-parse HEAD` \
		--build-arg BUILD_DATE=`date -u +”%Y-%m-%dT%H:%M:%SZ”` \
		.

# ==============================================================================
# Running from within docker compose

run: up seed

up:
	docker-compose -f zarf/compose/compose.yaml -f zarf/compose/compose-config.yaml up --detach --remove-orphans

down:
	docker-compose -f zarf/compose/compose.yaml down --remove-orphans

logs:
	docker-compose -f zarf/compose/compose.yaml logs -f

# ==============================================================================
# Running from within k8s/dev

kind-up:
	kind create cluster --image kindest/node:v1.20.2 --name ardan-starter-cluster --config zarf/k8s/dev/kind-config.yaml

kind-up-m1:
	kind create cluster --image rossgeorgiev/kind-node-arm64 --name ardan-starter-cluster --config zarf/k8s/dev/kind-config.yaml

kind-down:
	kind delete cluster --name ardan-starter-cluster

kind-load:
	kind load docker-image sales-api-amd64:1.0 --name ardan-starter-cluster
	kind load docker-image metrics-amd64:1.0 --name ardan-starter-cluster

kind-services:
	kustomize build zarf/k8s/dev | kubectl apply -f -

kind-update: sales
	kind load docker-image sales-api-amd64:1.0 --name ardan-starter-cluster
	kubectl delete pods -lapp=sales-api

kind-metrics: metrics
	kind load docker-image metrics-amd64:1.0 --name ardan-starter-cluster
	kubectl delete pods -lapp=sales-api

kind-logs:
	kubectl logs -lapp=sales-api --all-containers=true -f --tail=100

kind-status:
	kubectl get nodes
	kubectl get pods --watch

kind-status-full:
	kubectl describe pod -lapp=sales-api

kind-shell:
	kubectl exec -it $(shell kubectl get pods | grep sales-api | cut -c1-26) --container app -- /bin/sh

kind-database:
	# ./admin --db-disable-tls=1 migrate
	# ./admin --db-disable-tls=1 seed

kind-delete:
	kustomize build zarf/k8s/dev | kubectl delete -f -

# ==============================================================================
# Administration

migrate:
	go run app/sales-admin/main.go migrate

seed: migrate
	go run app/sales-admin/main.go seed

# ==============================================================================
# Running tests within the local computer

test:
	go test ./... -count=1
	staticcheck ./...

# ==============================================================================
# Modules support

deps-reset:
	git checkout -- go.mod
	go mod tidy
	go mod vendor

tidy:
	go mod tidy
	go mod vendor

deps-upgrade:
	# go get $(go list -f '{{if not (or .Main .Indirect)}}{{.Path}}{{end}}' -m all)
	go get -u -t -d -v ./...
	go mod tidy
	go mod vendor

deps-cleancache:
	go clean -modcache

list:
	go list -mod=mod all

# ==============================================================================
# Docker support

FILES := $(shell docker ps -aq)

down-local:
	docker stop $(FILES)
	docker rm $(FILES)

clean:
	docker system prune -f	

logs-local:
	docker logs -f $(FILES)

# ==============================================================================
# GCP

export PROJECT = ardan-starter-kit
CLUSTER = ardan-starter-cluster
DATABASE = ardan-starter-db
ZONE = us-central1-b

gcp-config:
	@echo Setting environment for $(PROJECT)
	gcloud config set project $(PROJECT)
	gcloud config set compute/zone $(ZONE)
	gcloud auth configure-docker

gcp-project:
	gcloud projects create $(PROJECT)
	gcloud beta billing projects link $(PROJECT) --billing-account=$(ACCOUNT_ID)
	gcloud services enable container.googleapis.com

gcp-cluster:
	gcloud container clusters create $(CLUSTER) --enable-ip-alias --num-nodes=2 --machine-type=n1-standard-2
	gcloud compute instances list

gcp-upload:
	docker tag sales-api-amd64:1.0 gcr.io/$(PROJECT)/sales-api-amd64:1.0
	docker tag metrics-amd64:1.0 gcr.io/$(PROJECT)/metrics-amd64:1.0
	docker push gcr.io/$(PROJECT)/sales-api-amd64:1.0
	docker push gcr.io/$(PROJECT)/metrics-amd64:1.0

gcp-database:
	# Create User/Password
	gcloud beta sql instances create $(DATABASE) --database-version=POSTGRES_9_6 --no-backup --tier=db-f1-micro --zone=$(ZONE) --no-assign-ip --network=default
	gcloud sql instances describe $(DATABASE)

gcp-db-assign-ip:
	gcloud sql instances patch $(DATABASE) --authorized-networks=[$(PUBLIC-IP)/32]
	gcloud sql instances describe $(DATABASE)

gcp-db-private-ip:
	# IMPORTANT: Make sure you run this command and get the private IP of the DB.
	gcloud sql instances describe $(DATABASE)

gcp-services:
	# The zarf/k8s/stg/stg-config.yaml file needs the private IP of the database.
	kustomize build zarf/k8s/stg | kubectl apply -f -
	# kubectl create -f deploy-sales-api.yaml
	# kubectl expose -f expose-sales-api.yaml --type=LoadBalancer

gcp-status:
>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92
	gcloud container clusters list
	kubectl get nodes
	kubectl get pods
	kubectl get services sales-api
<<<<<<< HEAD
	@echo ======================================================================

shell:
	# kubectl get pods
	kubectl exec -it <POD NAME> --container sales-api  -- /bin/sh
	# ./admin --db-disable-tls=1 migrate
	# ./admin --db-disable-tls=1 seed
	@echo ======================================================================

delete:
	kubectl delete services sales-api
	kubectl delete deployment sales-api	
	gcloud container clusters delete sales-api-cluster
	gcloud projects delete sales-api
	gcloud container images delete gcr.io/ardan-starter-kit/sales-api-amd64:1.0 --force-delete-tags
	gcloud container images delete gcr.io/ardan-starter-kit/metrics-amd64:1.0 --force-delete-tags
	docker image remove gcr.io/sales-api/sales-api-amd64:1.0
	docker image remove gcr.io/sales-api/metrics-amd64:1.0
	@echo ======================================================================
=======

gcp-logs:
	kubectl logs -lapp=sales-api --all-containers=true -f

gcp-shell:
	kubectl exec -it $(shell kubectl get pods | grep sales-api | cut -c1-26 | head -1) --container app -- /bin/sh
	# ./admin --db-disable-tls=1 migrate
	# ./admin --db-disable-tls=1 seed

gcp-delete:
	kubectl delete services sales-api
	kubectl delete deployment sales-api	
	gcloud container clusters delete $(CLUSTER)
	gcloud projects delete sales-api
	gcloud container images delete gcr.io/$(PROJECT)/sales-api-amd64:1.0 --force-delete-tags
	gcloud container images delete gcr.io/$(PROJECT)/metrics-amd64:1.0 --force-delete-tags
	docker image remove gcr.io/sales-api/sales-api-amd64:1.0
	docker image remove gcr.io/sales-api/metrics-amd64:1.0
>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92

#===============================================================================
# GKE Installation
#
# Install the Google Cloud SDK. This contains the gcloud client needed to perform
# some operatings
# https://cloud.google.com/sdk/
#
# Installing the K8s kubectl client. 
# https://kubernetes.io/docs/tasks/tools/install-kubectl/