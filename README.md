![Oozou](https://cdn.oozou.com/assets/logo-29352bd92fe47c629c5ff5f3885ed9fea425a4cf4db8ccc8ba253ad2fe2d373d.png)


## Introduction

This is a technical test for the role of **DevOps Engineer**.

## Objectives

This test helps us to understand
- how do you approach infrastructure design
- how do you manage microservices communication
- how do you consider security implications

## Project Setup

Project root has [`index.js`](/index.js) file. It simulates a simple app that runs infinitely & sends metrics to a [`statsd`](https://github.com/statsd/statsd) server.

## Exercices

  1. Add a `Dockerfile` to containerize the app, with support for multiple environments (test, development & production)
  2. Add a `docker-compose.yml` file to setup Node app, `statsd` & the backend. Applicants can use any backends for `statsd` (eg: `Graphite`).
  3. Use any IAC tools (Cloudformation, Terraform etc.) to prepare the infrastructure
  4. (Optional) Deploy on any cloud computing platforms

## Submitting Your Code

Email us your Github repo. We expect meaningful git commits, ideally one commit per exercise with commit messages clearly communicating the intent.

In case you deploy it to any cloud platforms, please send us instructions & relevant IAM user credentials.

---

# Walkthrough

## Technology stacks
* Docker
* Docker-compose
* Terraform
* Github Actions
* AWS ECS

## Application Environment Variables
### App
* `$METRICS_BACKEND_HOST` (Backend Host, default to `graphite`)
* `$METRICS_BACKEND_PORT` (Backend Port, default to `8125`)
### Graphite
* `$COLLECTD` (enable[1] or disable[0] collectd, default to `1`)
* `GRAPHITE_TIME_ZONE` (graphite web ui timezone, default to `Asia/Bangkok`)
* `$GRAPHITE_DEBUG` (enable[1] or disable[0] debug mode, default to `1`)

## Dockerize application
### Using Docker
```bash
docker build -t $image_name:$imagetag -f $docker_file .
```
### Using Docker-compose
The [`docker-compose.yml`](/docker-compose.yml) consists of the following. </br>
* app (simple app & send metrics to statsd)
* graphite (statsd & graphite as a backend)
```bash
docker-compose up -d
```
### Using Github Actions
The Github Actions consists of following steps. [`(build-deploy-ecs.yml)`](/.github/workflows/build-deploy-ecs.yml) </br>
1. Check out source code from main branch.
2. Configure AWS credentials `(retrieve access key and secret key from Github repository secrets)`.
3. Login to AWS ECR.
4. Get imagetag from `package.json`.
5. Build image & tag & push to AWS ECR.
6. Update new image tag to task definition.
7. Deploy to AWS ECS service with new task definition.

#### Running Github Actions
```
There are two ways to run.
1. Merge, push to main branch will trigger Github Actions.
2. Manually trigger Github Actions.
```