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