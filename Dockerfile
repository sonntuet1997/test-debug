FROM golang:1.19.3-alpine
RUN go install github.com/go-delve/delve/cmd/dlv@latest
ARG _srcdir="/src"
WORKDIR ${_srcdir}
RUN mkdir bin
COPY ./go.mod ./go.sum ${_srcdir}/
RUN --mount=type=ssh go mod download
COPY . ${_srcdir}
RUN #go build -o ./bin -gcflags="all=-N -l" ./...
RUN CGO_ENABLED=0 GOARCH=arm64 go build -gcflags="all=-N -l" -a -o ./bin ./...
ENTRYPOINT ["/bin/sh"]
#CMD ["-c", "/src/bin/awesomeProject & /go/bin/dlv --listen=:2345 --headless=true --api-version=2 --accept-multiclient attach $! --continue"]
CMD ["-c", "/go/bin/dlv --listen=:2345 --headless=true --api-version=2 --accept-multiclient --allow-non-terminal-interactive=true exec /src/bin/awesomeProject --continue"]
