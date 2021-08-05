FROM golang:1.16-buster AS builder

RUN mkdir /home/build
WORKDIR /home/build
COPY main.go go.mod go.sum ./
RUN go build -v

FROM debian:buster

COPY --from=builder /home/build/fritzbox_exporter ./fritzbox_exporter
COPY *.json ./
EXPOSE 9042
ENTRYPOINT ["/fritzbox_exporter"]
