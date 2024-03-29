{{/*
Expand the name of the chart.
*/}}
{{- define "mongo-datastore.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mongo-datastore.fullname" -}}
mongo-datastore
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mongo-datastore.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mongo-datastore.labels" -}}
helm.sh/chart: {{ include "mongo-datastore.chart" . }}
{{ include "mongo-datastore.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mongo-datastore.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mongo-datastore.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mongo-datastore.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mongo-datastore.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
