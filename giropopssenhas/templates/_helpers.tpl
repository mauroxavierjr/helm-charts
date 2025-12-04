{{/*
Criar as tags
*/}}
{{- define "app.labels" -}}
app: {{ .labels.app | quote }}
env: {{ .labels.env | quote }}
live: {{ .labels.live | quote }}
{{- end }}

{{/*
Definir os limites de recursos
*/}}
{{- define "app.resources" -}}
requests:
  memory: {{ .resources.requests.memory | default "256Mi" | quote }} 
  cpu: {{ .resources.requests.cpu | default "250m" | quote }}
limits:
  memory: {{ .resources.limits.memory | default "512Mi" | quote }}
  cpu: {{ .resources.limits.cpu | default "500m" | quote }}
{{- end }}

{{/*
Definir as portas dos containers
*/}}
{{- define "app.ports" -}}
{{ range .ports }}
- containerPort: {{ .port }}
{{- end }}
{{- end }}

{{/*
Definir database configmap
*/}}
{{- define "database.configmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .component }}-databases-config
data:
  app-config.yaml: |
    {{ toYaml .config | nindent 4}}
{{- end }}

{{/*
Definir observability configmap
*/}}
{{- define "observability.configmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .component }}-observability-config
data:
  app-config.json: |
    {{ toJson .config }}
{{- end }}


