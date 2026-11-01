# Argumentation Microservices for TypeScript

Generated [protobuf-es](https://github.com/bufbuild/protobuf-es) code of the [arg-services](https://github.com/recap-utr/arg-services) Protobuf definitions for building complex argumentation machines.
Documentation can be found at the [Buf Schema Registry](https://buf.build/recap/arg-services).

## Usage

Each Protobuf file is exported on its own, e.g. `arg-services/graph/v1/graph_pb`.
To call the services, install [`@connectrpc/connect`](https://connectrpc.com/docs/web/getting-started) and pass the generated service descriptors to `createClient`.

## Build Locally

`npm run build`
