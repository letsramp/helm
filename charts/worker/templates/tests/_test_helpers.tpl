{{/*
Payload for a new REST configuration
*/}}
{{- define "worker-test.restPayload" -}}
containers:
- name: test1
  image:
    repository: weaveworksdemos/payment
    tag: 0.4.3
  ports:
    - payment-port80

ports:
- name: payment-port80
  port: 80
  endpoints:
    - health
    - auth

endpoints:
- name: health
  path: /health
  methods:
    - type: GET
      output: health-output
      name: health-get
- name: auth
  path: /paymentAuth
  methods:
    - type: POST
      output: auth-output
      name: auth-post

signatures:
- name: health-output
  fields:
    - name: service
      type: string
      default: payment
    - name: status
      type: string
      default: up
    - name: time
      type: string
      default: current
- name: auth-output
  fields:
    - name: authorised
      type: bool
      default: true
{{- end }}

{{/*
Payload for a proto file 
*/}}
{{- define "worker-test.demo-proto" -}}
syntax = "proto3";

option go_package = "google.golang.org/grpc/examples/helloworld/helloworld";
option java_multiple_files = true;
option java_package = "io.grpc.examples.helloworld";
option java_outer_classname = "HelloWorldProto";

package helloworld;

// The greeting service definition.
service Greeter {
  // Sends a greeting
  rpc SayHello (HelloRequest) returns (HelloReply) {}
}

// The request message containing the user's name.
message HelloRequest {
  string name = 1;
}

// The response message containing the greetings
message HelloReply {
  string message = 1;
}
{{- end }}

{{/*
Payload for a gRPC mock description
*/}}
{{- define "worker-test.grpcPayload" -}}
containers:
- name: helloworld
  ports:
    - helloworld 
  image:
    repository: whatever
    tag: latest

ports:
- name: helloworld 
  endpoints:
    - helloworld
  protocol: grpc
  port: 50051

endpoints:
- name: helloworld
  defined:
    name: Greeter # Name could be omitted if equal to endpoint's name
    path: "/usr/local/lib/skyramp/idl/grpc/files/helloworld.proto"
  methods:
    - name: SayHello
      responseValue: HelloReply 

responseValues:
  - name: HelloReply
    blob: |
      { "message": "test" }
{{- end }}