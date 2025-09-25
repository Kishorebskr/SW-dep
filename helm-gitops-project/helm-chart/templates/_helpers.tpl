{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "web-app.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "fullname" -}}
{{- printf "%s-%s" .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "chart.name" -}}
{{ .Chart.Name | quote }}
{{- end -}}

{{- define "chart.version" -}}
{{ .Chart.Version | quote }}
{{- end -}}

{{- define "chart.appVersion" -}}
{{ .Chart.AppVersion | quote }}
{{- end -}}

{{- define "namespace" -}}
{{ .Values.namespace | default .Release.Namespace }}
{{- end -}}

{{- define "service.port" -}}
{{ .Values.service.port | default 80 }}
{{- end -}}

{{- define "ingress.hosts" -}}
{{- range .Values.ingress.hosts }}
{{ . | quote }}{{- if not (last) }}, {{- end }}
{{- end }}
{{- end -}}