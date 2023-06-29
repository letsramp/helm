{{/*
Expand the name of the chart.
*/}}
{{- define "worker.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "worker.fullname" -}}
skyramp-worker
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "worker.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "worker.labels" -}}
helm.sh/chart: {{ include "worker.chart" . }}
{{ include "worker.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "worker.selectorLabels" -}}
app.kubernetes.io/name: {{ include "worker.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: skyramp
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "worker.serviceAccountName" -}}
{{ include "worker.fullname" . }}
{{- end }}

{{/*
Create the name of the cluster role to use
*/}}
{{- define "worker.clusterRoleName" -}}
{{- if .Values.rbac }}
{{- printf "%s-%s" (include "worker.fullname" .) .Release.Namespace }}
{{- end }}
{{- end }}

{{/*
Boot config
*/}}
{{- define "worker.bootConfig" -}}
{{- toYaml .Values.bootConfig.config }}
{{- end }}

{{/*
Management plane config
*/}}
{{- define "worker.managementPlaneConfig" -}}
{{- toYaml .Values.ManagementPlaneConfig }}
{{- end }}

{{/*
Create the name of the worker user file config maps and volumes to use
*/}}
{{- define "worker.userFilesConfigMapName" -}}
{{- printf "%s-%s" (include "worker.fullname" .) "files" }}
{{- end }}

{{- define "worker.userGrpcFilesConfigMapName" -}}
{{- printf "%s-%s" (include "worker.userFilesConfigMapName" .) "grpc" }}
{{- end }}

{{- define "worker.userThriftFilesConfigMapName" -}}
{{- printf "%s-%s" (include "worker.userFilesConfigMapName" .) "thrift" }}
{{- end }}

{{- define "worker.baseUserFilesMountPath" -}}
/etc/skyramp/idl
{{- end }}

{{- define "worker.userThriftFilesMountPath" -}}
{{ include "worker.baseUserFilesMountPath" . }}/thrift/files
{{- end }}

{{- define "worker.userGrpcFilesMountPath" -}}
{{ include "worker.baseUserFilesMountPath" . }}/grpc/files
{{- end }}
