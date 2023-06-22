{{/*
Expand the name of the chart.
*/}}
{{- define "web-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "web-server.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "backend.fullname" -}}
{{.Values.backend.name }}
{{- end }}

{{- define "frontend.fullname" -}}
{{.Values.frontend.name }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "web-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "web-server.labels" -}}
helm.sh/chart: {{ include "web-server.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common backend labels
*/}}
{{- define "backend.labels" -}}
helm.sh/chart: {{ include "web-server.chart" . }}
{{ include "backend.selectorLabels" . }}
{{ include "web-server.labels" . }}
{{- end }}

{{/*
Backend selector labels
*/}}
{{- define "backend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "backend.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common frontend labels
*/}}
{{- define "frontend.labels" -}}
helm.sh/chart: {{ include "web-server.chart" . }}
{{ include "frontend.selectorLabels" . }}
{{ include "web-server.labels" . }}
{{- end }}

{{/*
Frontend selector labels
*/}}
{{- define "frontend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "frontend.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "web-server.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "backend.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Create the name of the cluster role to use
*/}}
{{- define "backend.clusterRoleName" -}}
{{- if .Values.rbac }}
{{- printf "%s-%s" (include "backend.fullname" .) .Release.Namespace }}
{{- end }}
{{- end }}
