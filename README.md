# Doppler Sample Dockerfile

This sample serves as a blueprint for the injection of environment variables from Doppler into a container.

## Setup

Navigate to your [account settings](https://docs.releasehub.com/reference-guide/account-settings) and [create a new build arg](https://docs.releasehub.com/reference-guide/account-settings/build-args). The key should be `DOPPLER_TOKEN` and the value should be the value of [your generated service token](https://docs.doppler.com/docs/service-tokens). The build argument can be specified at the account level, making it available to every application, or it can be made application specific.

