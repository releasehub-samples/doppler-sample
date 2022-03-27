# Managing Secrets in Release with Doppler

Example application showing how you can access your Doppler secrets in an environment being run on the Release platform.
## About Release

Release makes it easy to create cloud native full-stack environments with data, on demand. These environments can be used
for feature previews, quality assurance purposes, sales demonstrations, or running production environments.

## Setup

### Doppler

To start off, we need to [log into Doppler](https://dashboard.doppler.com/).

You'll need to pick a project and select an environment to pull secrets from.

![Screenshot showing sample environment on Doppler UI](images/image_one.png)

For testing purposes, let's insert a new variable into the selected environment as `TEST_VARIABLE`. Set the value to 
your first name.

![Screenshot showing TEST_VARIABLE with value of Josh](images/image_two.png)

Now, you'll need to [generate a service token](https://docs.doppler.com/docs/service-tokens) from that environment. Copy the 
generated token somewhere, you'll need it for the next step.

![Screenshot showing service token being generated](images/image_three.png)

### Release
You'll need a few things to get your application going.

Fork this repository so that you can create a new Release application with it against your GitHub.

Using your favorite browser, you'll need to [sign into Release](https://app.releasehub.com/auth/login-page).

Then we'll want to [create a new application](https://docs.releasehub.com/getting-started/create-an-application) 
based on your fork of this repository.

When you get to the Application Template page, copy and paste the following template into the browser.

```
---
app: doppler-sample
auto_deploy: true
context: release-customer-us-west-2
domain: rls.sh
repo_name: releasehub-samples/doppler-sample
hostnames:
- service: service-doppler-sample-${env_id}.${domain}
environment_templates:
- name: ephemeral
resources:
  cpu:
    limits: 1000m
    requests: 100m
  memory:
    limits: 1Gi
    requests: 100Mi
  replicas: 1
services:
- name: service
  image: release-samples/doppler-sample/service
  build:
    context: "."
  has_repo: true
  ports:
  - type: node_port
    target_port: '8080'
    port: '8080'
workflows:
- name: setup
  order_from:
  - services.all
- name: teardown
  parallelize:
  - step: remove_environment
    tasks:
    - release.remove_environment
- name: patch
  order_from:
  - services.all
```

Click the button and start the process to build and deploy your environment.

Once it's done, go to the ingress URL for your newly created environment and witness your name being printed to the 
screen!
