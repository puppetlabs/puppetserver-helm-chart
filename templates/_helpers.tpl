{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "puppetserver.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 29 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "puppetserver.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 52 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "puppetserver.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 29 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf .Release.Name | trunc 29 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 29 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create the args array for "r10k_code_cronjob.sh"
*/}}
{{- define "r10k.code.args" -}}
{{- join " " .Values.r10k.code.extraArgs }}
{{- end -}}

{{/*
Create the args array for "r10k_hiera_cronjob.sh"
*/}}
{{- define "r10k.hiera.args" -}}
{{- join " " .Values.r10k.hiera.extraArgs }}
{{- end -}}

{{/*
Create unified labels for Puppetserver components
*/}}
{{- define "puppetserver.common.matchLabels" -}}
app: {{ template "puppetserver.name" . }}
release: {{ .Release.Name }}
{{- end -}}

{{- define "puppetserver.common.metaLabels" -}}
chart: {{ template "puppetserver.chart" . }}
heritage: {{ .Release.Service }}
{{- end -}}

{{- define "puppetserver.puppet.labels" -}}
{{ include "puppetserver.common.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.hiera.labels" -}}
{{ include "puppetserver.hiera.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.hiera.matchLabels" -}}
component: {{ .Values.hiera.name | quote }}
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.r10k.labels" -}}
{{ include "puppetserver.r10k.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.r10k.matchLabels" -}}
component: {{ .Values.r10k.name | quote }}
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.postgresql.labels" -}}
{{ include "puppetserver.postgresql.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.postgresql.matchLabels" -}}
component: {{ .Values.postgresql.name | quote }}
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetdb.labels" -}}
{{ include "puppetserver.puppetdb.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetdb.matchLabels" -}}
component: {{ .Values.puppetdb.name | quote }}
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetboard.labels" -}}
{{ include "puppetserver.puppetboard.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetboard.matchLabels" -}}
component: {{ .Values.puppetboard.name | quote }}
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetserver.labels" -}}
{{ include "puppetserver.puppetserver.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetserver.matchLabels" -}}
component: {{ .Values.puppetserver.name | quote }}
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetserver-compilers.labels" -}}
{{ include "puppetserver.puppetserver-compilers.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetserver-compilers.matchLabels" -}}
component: "{{ .Values.puppetserver.name }}-compilers"
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetserver-data.labels" -}}
{{ include "puppetserver.puppetserver-data.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetserver-data.matchLabels" -}}
component: "{{ .Values.puppetserver.name }}-serverdata"
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{/*
Set mandatory Puppet Server Masters' Service name.
*/}}
{{- define "puppetserver.puppetserver-masters.serviceName" -}}
puppet
{{- end -}}

{{/*
Set secondary Puppet Server Masters' Service name for Puppet Agents.
*/}}
{{- define "puppetserver.puppetserver.agents-to-masters.serviceName" -}}
agents-to-puppet
{{- end -}}

{{/*
Set mandatory Puppet Server Compilers' Service name.
*/}}
{{- define "puppetserver.puppetserver-compilers.serviceName" -}}
puppet-compilers
{{- end -}}

{{/*
Puppet Masters' port.
*/}}
{{- define "puppetserver.puppetserver-masters.port" -}}
{{- if .Values.puppetserver.masters.service.ports.puppetserver.port -}}
{{- .Values.puppetserver.masters.service.ports.puppetserver.port -}}
{{- else -}}
8140
{{- end -}}
{{- end -}}

{{/*
Puppet Compilers' port.
*/}}
{{- define "puppetserver.puppetserver-compilers.port" -}}
{{- if .Values.puppetserver.compilers.service.ports.puppetserver.port -}}
{{- .Values.puppetserver.compilers.service.ports.puppetserver.port -}}
{{- else -}}
8140
{{- end -}}
{{- end -}}

{{/*
Set's the affinity for pod placement
when running with multiple Puppet compilers.
*/}}
{{- define "puppetserver.compilers.affinity" -}}
    {{- if (or (.Values.affinity) (and (.Values.puppetserver.compilers.enabled) (.Values.puppetserver.compilers.podAntiAffinity))) }}
      affinity:
      {{- if (.Values.affinity) }}
        {{- toYaml .Values.affinity | nindent 8 }}
      {{- end }}
      {{- if (.Values.puppetserver.compilers.podAntiAffinity) }}
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            - labelSelector:
                matchLabels:
                  {{- include "puppetserver.puppetserver-compilers.matchLabels" . | nindent 18 }}
              topologyKey: kubernetes.io/hostname
      {{- end }}
    {{- end }}
{{- end -}}

{{/*
Calculates the max. number of compilers
*/}}
{{- define "puppetserver.compilers.maxNo" -}}
{{- if not (.Values.puppetserver.compilers.autoScaling.enabled) -}}
{{- .Values.puppetserver.compilers.manualScaling.compilers -}}
{{- else -}}
{{- .Values.puppetserver.compilers.autoScaling.maxCompilers -}}
{{- end -}}
{{- end -}}

{{- define "puppetserver.compilers.hostnames" -}}
  {{- $dot := . -}}
  {{- range $compilersLoopCount, $e := until ((include "puppetserver.compilers.maxNo" $dot) | int) -}}
    {{- printf "%s-puppetserver-compiler-%d" (include "puppetserver.name" $dot) $compilersLoopCount -}}
    {{- if lt $compilersLoopCount  ( sub ((include "puppetserver.compilers.maxNo" $dot) | int) 1 ) -}}
      {{- printf "," -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/*
Return PostgreSQL username
*/}}
{{- define "postgresql.username" -}}
{{- if .Values.global.credentials.username }}
  {{- .Values.global.credentials.username -}}
{{- else -}}
  {{- .Values.postgresqlUsername -}}
{{- end -}}
{{- end -}}

{{/*
Return PuppetDB and PostgreSQL password
*/}}
{{- define "postgresql.password" -}}
{{- if .Values.global.credentials.password }}
  {{- .Values.global.credentials.password -}}
{{- else if .Values.postgresqlPassword -}}
  {{- .Values.postgresqlPassword -}}
{{- else -}}
  unbreakablePassword
{{- end -}}
{{- end -}}

{{/*
Return PuppetDB and PostgreSQL password
*/}}
{{- define "postgresql.postgres.password" -}}
{{- if .Values.global.credentials.password }}
  {{- .Values.global.credentials.password -}}
{{- else if .Values.postgresqlPostgresPassword -}}
    {{- .Values.postgresqlPostgresPassword -}}
{{- else -}}
  unbreakablePassword
{{- end -}}
{{- end -}}

{{/*
Create the name for the PuppetDB password secret.
*/}}
{{- define "puppetdb.secret" -}}
{{- if .Values.global.credentials.existingSecret -}}
  {{- .Values.global.credentials.existingSecret -}}
{{- else -}}
  puppetdb-secret
{{- end -}}
{{- end -}}

{{/*
Create the name for the r10k.code secret.
*/}}
{{- define "r10k.code.secret" -}}
{{- if .Values.r10k.code.viaSsh.credentials.existingSecret -}}
  {{- .Values.r10k.code.viaSsh.credentials.existingSecret -}}
{{- else -}}
  r10k-code-creds
{{- end -}}
{{- end -}}

{{/*
Create the name for the r10k.hiera secret.
*/}}
{{- define "r10k.hiera.secret" -}}
{{- if .Values.r10k.hiera.viaSsh.credentials.existingSecret -}}
  {{- .Values.r10k.hiera.viaSsh.credentials.existingSecret -}}
{{- else -}}
  r10k-hiera-creds
{{- end -}}
{{- end -}}

{{/* *************************************************************************************
The following definitions were more complex and necessary during part of this development.
Now they are essentially just stubs but left here in case they might be needed again soon.
************************************************************************************* */}}

{{/*
Create the name for the hiera eyaml key configMap (private/public keys combined).
*/}}
{{- define "puppetserver.hiera.existingMap" -}}
{{- if .Values.hiera.eyaml.existingMap -}}
  {{- .Values.hiera.eyaml.existingMap -}}
{{- end -}}
{{- end -}}

{{/*
Create the name for the hiera eyaml private key configMap.
*/}}
{{- define "puppetserver.hiera.privateMap" -}}
  eyamlpriv-config
{{- end -}}

{{/*
Create the name for the hiera eyaml public cert configMap.
*/}}
{{- define "puppetserver.hiera.publicMap" -}}
  eyamlpub-config
{{- end -}}
