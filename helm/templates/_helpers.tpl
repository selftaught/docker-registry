{{/* Generate the application name */}}
{{- define "docker-registry.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Create fully qualified name */}}
{{- define "docker-registry.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name (include "docker-registry.name" .) | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/* Common labels */}}
{{- define "docker-registry.labels" -}}
app.kubernetes.io/name: {{ include "docker-registry.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: container-registry
{{- end }}

{{/* Selector labels */}}
{{- define "docker-registry.selectorLabels" -}}
app.kubernetes.io/name: {{ include "docker-registry.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* Service account name */}}
{{- define "docker-registry.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "docker-registry.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/* Registry image reference */}}
{{- define "docker-registry.registryImage" -}}
{{- printf "%s:%s" .Values.platform.image.repository .Values.platform.image.tag }}
{{- end }}

{{/* Interface image reference */}}
{{- define "docker-registry.interfaceImage" -}}
{{- printf "%s:%s" .Values.interface.component.image .Values.interface.component.tag }}
{{- end }}