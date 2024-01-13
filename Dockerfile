FROM golang:1.19.3-alpine
RUN go install github.com/go-delve/delve/cmd/dlv@latest
ARG _srcdir="/src"
WORKDIR ${_srcdir}
RUN mkdir bin
COPY . ${_srcdir}
RUN #go build -o ./bin -gcflags="all=-N -l" ./...
RUN CGO_ENABLED=0 GOARCH=arm64 GOOS=linux go build -gcflags="all=-N -l" -a -o ./bin ./...
ENTRYPOINT ["/go/bin/dlv", "--listen=:2345", "--headless=true", "--api-version=2", "--log", "--accept-multiclient", "exec","--continue", "/src/bin/awesomeProject"]