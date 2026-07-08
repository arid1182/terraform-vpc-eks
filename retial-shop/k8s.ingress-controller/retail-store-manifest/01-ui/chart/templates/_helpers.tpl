{{/*
Common labels shared across all resources
*/}}
{{- define "ui.labels" -}}
app.kubernetes.io/name: {{ .Values.deployment.name }}
app.kubernetes.io/instance: {{ .Values.global.instance }}
app.kubernetes.io/component: {{ .Values.global.component }}
app.kubernetes.io/owner: {{ .Values.global.owner }}
{{- end }}

{{/*
Chart metadata labels (for tracking helm releases)
*/}}
{{- define "ui.chartLabels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Ingress-specific labels
*/}}
{{- define "ui.ingress.labels" -}}
app.kubernetes.io/name: {{ .Values.ingress.name }}
app.kubernetes.io/instance: {{ .Values.global.instance }}
app.kubernetes.io/component: {{ .Values.ingress.component }}
app.kubernetes.io/owner: {{ .Values.global.owner }}
{{- end }}
