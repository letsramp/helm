{{/*
Expand the name of the chart.
*/}}
{{- define "skyramp-mocker.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "skyramp-mocker.fullname" -}}
{{- .Chart.Name }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "skyramp-mocker.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "skyramp-mocker.labels" -}}
helm.sh/chart: {{ include "skyramp-mocker.chart" . }}
{{ include "skyramp-mocker.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "skyramp-mocker.selectorLabels" -}}
app.kubernetes.io/name: {{ include "skyramp-mocker.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: skyramp
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "skyramp-mocker.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "skyramp-mocker.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Boot config
*/}}
{{- define "skyramp-mocker.bootConfig" -}}
{{- toYaml .Values.bootConfig.config }}
{{- end }}

{{/*
Create the name of the mocker user file config maps and volumes to use
*/}}
{{- define "skyramp-mocker.userFilesConfigMapName" -}}
{{- printf "%s-%s" (include "skyramp-mocker.fullname" .) "files" }}
{{- end }}

{{- define "skyramp-mocker.userGrpcFilesConfigMapName" -}}
{{- printf "%s-%s" (include "skyramp-mocker.userFilesConfigMapName" .) "grpc" }}
{{- end }}

{{- define "skyramp-mocker.userThriftFilesConfigMapName" -}}
{{- printf "%s-%s" (include "skyramp-mocker.userFilesConfigMapName" .) "thrift" }}
{{- end }}

{{- define "skyramp-mocker.baseUserFilesMountPath" -}}
/usr/local/lib/skyramp/idl
{{- end }}

{{- define "skyramp-mocker.userThriftFilesMountPath" -}}
{{ include "skyramp-mocker.baseUserFilesMountPath" . }}/thrift/files
{{- end }}

{{- define "skyramp-mocker.userGrpcFilesMountPath" -}}
{{ include "skyramp-mocker.baseUserFilesMountPath" . }}/grpc/files
{{- end }}