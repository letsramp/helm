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