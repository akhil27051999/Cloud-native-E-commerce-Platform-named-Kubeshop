FROM golang:1.20-alpine

WORKDIR /app
COPY go.mod ./
COPY main.go ./

RUN go build -o payments main.go

CMD ["./payments"]

