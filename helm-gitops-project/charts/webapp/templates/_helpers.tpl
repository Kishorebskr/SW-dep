{{- define "webapp.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "webapp.service.name" -}}
{{- printf "%s" (include "webapp.fullname" .) -}}
{{- end -}}

{{- define "webapp.ingress.hosts" -}}
{{- if .Values.ingress.hosts }}
{{- range .Values.ingress.hosts }}
{{ . }}{{- if not (last .Values.ingress.hosts) }},{{ end }}
{{- end }}
{{- end -}}
{{- end -}}

{{- define "webapp.labels" -}}
app: {{ include "webapp.fullname" . }}
{{- end -}}