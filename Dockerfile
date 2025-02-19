FROM golang:1.20.5-alpine AS builder
RUN apk add --no-cache git
WORKDIR /app
COPY . /app
RUN go mod download
RUN go build ./cmd/katana

FROM alpine:3.18.0
RUN apk -U upgrade --no-cache \
    && apk add --no-cache bind-tools ca-certificates chromium
COPY --from=builder /app/katana /usr/local/bin/

ENTRYPOINT ["katana"]
