{{/*
Payload for a new REST configuration
*/}}
{{- define "skyramp-mocker-test.restPayload" -}}
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
{{- define "skyramp-mocker-test.demo-proto" -}}
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
{{- define "skyramp-mocker-test.grpcPayload" -}}
containers:
- name: helloworld
  ports:
    - port1
    - port2
  image:
    repository: whatever
    tag: latest

ports:
- name: port1
  endpoints:
    - helloworld
  protocol: grpc
  port: 50051
- name: port2
  endpoints:
    - helloworld2
  protocol: grpc
  port: 50059

endpoints:
- name: helloworld
  defined:
    name: Greeter # Name could be omitted if equal to endpoint's name
    path: "/usr/local/lib/skyramp/idl/grpc/files/helloworld.proto"
  methods:
    - name: SayHello
      input: HelloRequest
      output: HelloReply
- name: helloworld2
  defined:
    name: Greeter # Name could be omitted if equal to endpoint's name
    path: "/usr/local/lib/skyramp/idl/grpc/files/helloworld.proto"
  methods:
    - name: SayHello
      input: HelloRequest
      output: HelloReply

signatures:
- name: HelloRequest
  fields:
  - name: name
    type: string
- name: HelloReply
  fields:
  - name: message
    type: string
    default: "test"
{{- end }}