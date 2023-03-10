{{/*
Expand the name of the chart.
*/}}
{{- define "mocker.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mocker.fullname" -}}
{{- .Chart.Name }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mocker.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mocker.labels" -}}
helm.sh/chart: {{ include "mocker.chart" . }}
{{ include "mocker.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mocker.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mocker.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: skyramp
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mocker.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mocker.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Boot config
*/}}
{{- define "mocker.bootConfig" -}}
{{- toYaml .Values.bootConfig.config }}
{{- end }}

{{/*
Create the name of the mocker user file config maps and volumes to use
*/}}
{{- define "mocker.userFilesConfigMapName" -}}
{{- printf "%s-%s" (include "mocker.fullname" .) "files" }}
{{- end }}

{{- define "mocker.userGrpcFilesConfigMapName" -}}
{{- printf "%s-%s" (include "mocker.userFilesConfigMapName" .) "grpc" }}
{{- end }}

{{- define "mocker.userThriftFilesConfigMapName" -}}
{{- printf "%s-%s" (include "mocker.userFilesConfigMapName" .) "thrift" }}
{{- end }}

{{- define "mocker.baseUserFilesMountPath" -}}
/usr/local/lib/skyramp/idl
{{- end }}

{{- define "mocker.userThriftFilesMountPath" -}}
{{ include "mocker.baseUserFilesMountPath" . }}/thrift/files
{{- end }}

{{- define "mocker.userGrpcFilesMountPath" -}}
{{ include "mocker.baseUserFilesMountPath" . }}/grpc/files
{{- end }}