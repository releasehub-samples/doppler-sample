FROM alpine:latest

# Creates a variable that is able to overridden at build time
ARG DOPPLER_TOKEN

# Set the environment variable DOPPLER_TOKEN to the variable that was injected at build time
ENV DOPPLER_TOKEN=${DOPPLER_TOKEN}

# Install the Doppler CLI
RUN wget -q -t3 'https://packages.doppler.com/public/cli/rsa.8004D9FF50437357.key' -O /etc/apk/keys/cli@doppler-8004D9FF50437357.rsa.pub && \
  echo 'https://packages.doppler.com/public/cli/alpine/any-version/main' | tee -a /etc/apk/repositories && \
  apk add doppler

# Run Doppler and print the environment variables
CMD ["doppler", "run", "--", "printenv"]