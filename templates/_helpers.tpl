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
{{- define "puppetserver.common.metaLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ template "puppetserver.chart" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
{{- end -}}

{{- define "puppetserver.common.matchLabels" -}}
app.kubernetes.io/name: {{ template "puppetserver.name" . }}
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
app.kubernetes.io/component: {{ .Values.hiera.name }}
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.r10k.labels" -}}
{{ include "puppetserver.r10k.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.r10k.matchLabels" -}}
app.kubernetes.io/component: {{ .Values.r10k.name }}
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.postgresql.labels" -}}
{{ include "puppetserver.postgresql.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.postgresql.matchLabels" -}}
app.kubernetes.io/component: {{ .Values.postgresql.name }}
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetdb.labels" -}}
{{ include "puppetserver.puppetdb.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetdb.matchLabels" -}}
app.kubernetes.io/component: {{ .Values.puppetdb.name }}
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetboard.labels" -}}
{{ include "puppetserver.puppetboard.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetboard.matchLabels" -}}
app.kubernetes.io/component: {{ .Values.puppetboard.name }}
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetserver.labels" -}}
{{ include "puppetserver.puppetserver.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetserver.matchLabels" -}}
app.kubernetes.io/component: {{ .Values.puppetserver.name }}
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetserver-compilers.labels" -}}
{{ include "puppetserver.puppetserver-compilers.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetserver-compilers.matchLabels" -}}
app.kubernetes.io/component: {{ .Values.puppetserver.name }}-compilers
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetserver-data.labels" -}}
{{ include "puppetserver.puppetserver-data.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetserver-data.matchLabels" -}}
app.kubernetes.io/component: {{ .Values.puppetserver.name }}-serverdata
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

{{/* Allow KubeVersion to be overridden. */}}
{{- define "puppetserver.kubeVersion" -}}
  {{- default .Capabilities.KubeVersion.Version .Values.kubeVersionOverride -}}
{{- end -}}

{{/* Get Ingress API Version */}}
{{- define "puppetserver.ingress.apiVersion" -}}
  {{- if and (.Capabilities.APIVersions.Has "networking.k8s.io/v1") (semverCompare ">= 1.19-0" (include "puppetserver.kubeVersion" .)) -}}
      {{- print "networking.k8s.io/v1" -}}
  {{- else if .Capabilities.APIVersions.Has "networking.k8s.io/v1beta1" -}}
    {{- print "networking.k8s.io/v1beta1" -}}
  {{- else -}}
    {{- print "extensions/v1beta1" -}}
  {{- end -}}
{{- end -}}

{{/* Check Ingress stability */}}
{{- define "puppetserver.ingress.isStable" -}}
  {{- eq (include "puppetserver.ingress.apiVersion" .) "networking.k8s.io/v1" -}}
{{- end -}}

{{/* Check Ingress supports pathType */}}
{{/* pathType was added to networking.k8s.io/v1beta1 in Kubernetes 1.18 */}}
{{- define "puppetserver.ingress.supportsPathType" -}}
  {{- or (eq (include "puppetserver.ingress.isStable" .) "true") (and (eq (include "puppetserver.ingress.apiVersion" .) "networking.k8s.io/v1beta1") (semverCompare ">= 1.18-0" (include "puppetserver.kubeVersion" .))) -}}
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
Create the name for the r10k.code.viaSsh secret.
*/}}
{{- define "r10k.code.viaSsh.secret" -}}
{{- if .Values.r10k.code.viaSsh.credentials.existingSecret -}}
  {{- .Values.r10k.code.viaSsh.credentials.existingSecret -}}
{{- else -}}
  r10k-code-creds
{{- end -}}
{{- end -}}

{{/*
Create the name for the r10k.code.viaHttps secret.
*/}}
{{- define "r10k.code.viaHttps.secret" -}}
{{- if .Values.r10k.code.viaHttps.credentials.existingSecret -}}
  {{- .Values.r10k.code.viaHttps.credentials.existingSecret -}}
{{- else -}}
  r10k-code-creds
{{- end -}}
{{- end -}}

{{/*
Create the name for the r10k.hiera.viaSsh secret.
*/}}
{{- define "r10k.hiera.viaSsh.secret" -}}
{{- if .Values.r10k.hiera.viaSsh.credentials.existingSecret -}}
  {{- .Values.r10k.hiera.viaSsh.credentials.existingSecret -}}
{{- else -}}
  r10k-hiera-creds
{{- end -}}
{{- end -}}

{{/*
Create the name for the r10k.hiera.viaHttps secret.
*/}}
{{- define "r10k.hiera.viaHttps.secret" -}}
{{- if .Values.r10k.hiera.viaHttps.credentials.existingSecret -}}
  {{- .Values.r10k.hiera.viaHttps.credentials.existingSecret -}}
{{- else -}}
  r10k-hiera-creds
{{- end -}}
{{- end -}}

{{/*
check if hiera is define
*/}}
{{- define "hiera.enable" -}}
{{- if or .Values.hiera.hieradataurl .Values.r10k.hiera.extraRepository }}
  {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Create the name for the hiera eyaml private key Secrets.
*/}}
{{- define "puppetserver.hiera.privateSecret" -}}
  eyamlpriv-secret
{{- end -}}

{{/*
Create the name for the hiera eyaml public cert Secrets.
*/}}
{{- define "puppetserver.hiera.publicSecret" -}}
  eyamlpub-secret
{{- end -}}

{{/*
Return the appropriate apiVersion for podsecuritypolicy.
*/}}
{{- define "podsecuritypolicy.apiVersion" -}}
{{- if semverCompare "<1.10-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "extensions/v1beta1" -}}
{{- else -}}
{{- print "policy/v1beta1" -}}
{{- end -}}
{{- end -}}

{{/*
Define puppetserver service Account name
*/}}
{{- define "puppetserver.puppetserver.serviceAccount.name" -}}
{{ default "puppetserver" .Values.puppetserver.serviceAccount.accountName }}
{{- end -}} 

{{/*
Define puppetdb service Account name
*/}}
{{- define "puppetserver.puppetdb.serviceAccount.name" -}}
{{ default "puppetdb" .Values.puppetdb.serviceAccount.accountName }}
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
Create the name for the hiera eyaml key secret (private/public keys combined).
*/}}
{{- define "puppetserver.hiera.existingSecret" -}}
{{- if .Values.hiera.eyaml.existingSecret -}}
  {{- .Values.hiera.eyaml.existingSecret -}}
{{- end -}}
{{- end -}}
