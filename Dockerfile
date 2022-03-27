FROM golang:1.17-alpine AS builder

# Creates a variable that is able to overridden at build time
ARG DOPPLER_TOKEN
ENV DOPPLER_TOKEN=${DOPPLER_TOKEN}

# Install the Doppler CLI
RUN wget -q -t3 'https://packages.doppler.com/public/cli/rsa.8004D9FF50437357.key' -O /etc/apk/keys/cli@doppler-8004D9FF50437357.rsa.pub && \
  echo 'https://packages.doppler.com/public/cli/alpine/any-version/main' | tee -a /etc/apk/repositories && \
  apk add doppler

ADD . /go/src/service
WORKDIR /go/src/service
COPY go.mod ./
RUN go mod download
COPY *.go ./
RUN go build -o /service

EXPOSE 8080

# Run Doppler in addition to the executable
CMD [ "doppler", "run", "--", "/service" ]