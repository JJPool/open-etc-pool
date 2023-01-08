# FROM golang:1.16-alpine AS build
FROM golang:1.19.4-bullseye AS build

# WORKDIR /app
WORKDIR /open-etc-pool

COPY go.mod ./
COPY go.sum ./
RUN go mod download

# COPY *.go ./
COPY . .
RUN go build -o /open-etc-pool -buildvcs=false
COPY . .
# RUN make

# EXPOSE 8080

FROM golang:1.19.4-bullseye
# FROM golang:1.16-alpine

WORKDIR /

COPY --from=build /open-etc-pool /open-etc-pool
RUN chmod +x /open-etc-pool/open-etc-pool

EXPOSE 8080

# USER nonroot:nonroot  

ENTRYPOINT /open-etc-pool/open-etc-pool config.json