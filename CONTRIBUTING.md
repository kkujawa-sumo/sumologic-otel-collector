# Contributing Guide

To contribute you will need to ensure you have the following setup:

* working Go environment

## How to build

```
$ cd otelcolbuilder && make build
opentelemetry-collector-builder \
                --config .otelcol-builder.yaml \
                --output-path ./cmd \
                --name otelcol-sumo
2021-05-24T16:29:03.494+0200    INFO    cmd/root.go:99  OpenTelemetry Collector distribution builder    {"version": "dev", "date": "unknown"}
2021-05-24T16:29:03.498+0200    INFO    builder/main.go:90      Sources created {"path": "./cmd"}
2021-05-24T16:29:03.612+0200    INFO    builder/main.go:126     Getting go modules
2021-05-24T16:29:03.957+0200    INFO    builder/main.go:107     Compiling
2021-05-24T16:29:09.770+0200    INFO    builder/main.go:113     Compiled        {"binary": "./cmd/otelcol-sumo"}
```

In order to build for a different platform one can use `otelcol-sumo-${platform}_${arch}`
make targets e.g.:

```
$ cd otelcolbuilder && make otelcol-sumo-linux_arm64
GOOS=linux   GOARCH=arm64 /Library/Developer/CommandLineTools/usr/bin/make build BINARY_NAME=otelcol-sumo-linux_arm64
opentelemetry-collector-builder \
                --config .otelcol-builder.yaml \
                --output-path ./cmd \
                --name otelcol-sumo-linux_arm64
2021-05-24T16:32:11.963+0200    INFO    cmd/root.go:99  OpenTelemetry Collector distribution builder    {"version": "dev", "date": "unknown"}
2021-05-24T16:32:11.965+0200    INFO    builder/main.go:90      Sources created {"path": "./cmd"}
2021-05-24T16:32:12.066+0200    INFO    builder/main.go:126     Getting go modules
2021-05-24T16:32:12.376+0200    INFO    builder/main.go:107     Compiling
2021-05-24T16:32:37.326+0200    INFO    builder/main.go:113     Compiled        {"binary": "./cmd/otelcol-sumo-linux_arm64"}
```