# HELM Chart for Puppet Server

## Introduction

This chart bootstraps Puppet Server and its components on a Kubernetes cluster using the Helm package manager.

## Prerequisites

### Code Repos

* You must specify your Puppet Control Repo using `puppetserver.puppeturl` variable in the `values.yaml` file or include `--set puppetserver.puppeturl=<your_public_repo>` in the command line of `helm install`. You should specify your separate Hieradata Repo as well using the `hiera.hieradataurl` variable.

* You can also use private repos. Just remember to specify your credentials using `r10k.code.viaSsh.credentials.ssh.value`. You can set similar credentials for your Hieradata Repo.

### Load-Balancing Puppet Server

In case a Load Balancer (LB) must sit in front of Puppet Server - please keep in mind that having a Network LB (operating at OSI Layer 4) is preferable.

### NGINX Ingress Controller Configuration

The Ingress resource is disabled by default, but if it is enabled then ssl-passthrough must be used so that puppet agents will get the expected server certificate when connecting to the service.  This feature must be enabled on the Ingress resource itself, but also must be enabled via command line argument to the NGINX Ingress Controller.  More information on that can be found [here](<https://kubernetes.github.io/ingress-nginx/user-guide/cli-arguments/>).

## Horizontal Scaling

To achieve better availability and higher throughput of Puppet Infrastructure, you'll need to scale out Puppet Masters and/or Puppet Compilers.

### Multiple Puppet Masters

To achieve better availability of Puppet Infrastructure, you'll need to scale out Puppet Server Masters using `.Values.puppetserver.masters.multiMasters`. These Servers are known as masters, and are responsible for the creation and signing of your Puppet Agents' certificates. They are also responsible for receiving catalog requests from agents and synchronize the results with each other.

### Multiple Puppet Compilers

To achieve better throughput of Puppet Infrastructure, you'll need to enable and scale out Puppet Server Compilers using `.Values.puppetserver.compilers`. These Servers are known as compile masters, and are simply additional load-balanced Puppet Servers that receive catalog requests from agents and synchronize the results with each other.

## Support for Helm v2

Those of you who would like to deploy the chart with Helm v2 - please use chart version `v1.x`.

## Installing the Chart

### Add Puppet Server Helm Repository

Before installing Puppet Server Helm chart, you need to add the [Puppet Server Helm repository](https://puppetlabs.github.io/puppetserver-helm-chart) to your Helm client as below.

```bash
helm repo add puppet https://puppetlabs.github.io/puppetserver-helm-chart
```

### Install the Chart

To install the chart with the release name `puppetserver`.

```bash
helm install --namespace puppetserver --name puppetserver puppet/puppetserver-helm-chart --set puppetserver.puppeturl='https://github.com/$SOMEUSER/control-repo.git'
```

> Note - If you do not specify a name, helm will select a name for you.

## Configuration

The following table lists the configurable parameters of the Puppetserver chart and their default values.

Parameter | Description | Default
--------- | ----------- | -------
`puppetserver.name` | puppetserver component label | `puppetserver`
`puppetserver.image` | puppetserver image | `puppet/puppetserver`
`puppetserver.tag` | puppetserver img tag | `6.10.0`
`puppetserver.pullPolicy` | puppetserver img pull policy | `IfNotPresent`
`puppetserver.masters.resources` | puppetserver masters resource limits | ``
`puppetserver.masters.extraEnv` | puppetserver masters additional container env vars |``
`puppetserver.masters.fqdns.alternateServerNames` | puppetserver masters alternate fqdns |``
`puppetserver.masters.service.type` | puppetserver masters svc type | `ClusterIP`
`puppetserver.masters.service.ports` | puppetserver masters svc exposed ports | `puppetserver`
`puppetserver.masters.service.annotations`| puppetserver masters svc annotations |``
`puppetserver.masters.service.labels`| puppetserver additional masters svc labels |``
`puppetserver.masters.service.loadBalancerIP`| puppetserver masters svc loadbalancer ip |``
`puppetserver.masters.ingress.enabled`| puppetserver masters ingress creation enabled |`false`
`puppetserver.masters.ingress.annotations`| puppetserver masters ingress annotations |``
`puppetserver.masters.ingress.extraLabels`| puppetserver masters ingress extraLabels |``
`puppetserver.masters.ingress.hosts`| puppetserver masters ingress hostnames |``
`puppetserver.masters.ingress.tls`| puppetserver masters ingress tls configuration |``
`puppetserver.masters.multiMasters.enabled` | If true, creates multiple Puppetserver masters | `false`
`puppetserver.masters.multiMasters.manualScaling.masters` | If multiple masters are enabled, this field sets masters count | `1`
`puppetserver.masters.multiMasters.autoScaling.enabled` | If true, creates masters Horizontal Pod Autoscaler | `false`
`puppetserver.masters.multiMasters.autoScaling.minMasters` | If masters autoscaling enabled, this field sets minimum masters count | `1`
`puppetserver.masters.multiMasters.autoScaling.maxMasters` | If masters autoscaling enabled, this field sets maximum masters count | `3`
`puppetserver.masters.multiMasters.autoScaling.cpuUtilizationPercentage` | Target masters CPU utilization percentage to scale | `75`
`puppetserver.masters.multiMasters.autoScaling.memoryUtilizationPercentage` | Target masters memory utilization percentage to scale | `75`
`puppetserver.compilers.enabled` | If true, creates Puppetserver compilers | `false`
`puppetserver.compilers.resources` | puppetserver compilers resource limits |``
`puppetserver.compilers.podAntiAffinity` | puppetserver compilers pod affinity constraints |`false`
`puppetserver.compilers.annotations`| puppetserver compilers statefulset annotations |``
`puppetserver.compilers.extraEnv` | puppetserver compilers additional container env vars |``
`puppetserver.compilers.manualScaling.compilers` | If multiple compilers are enabled, this field sets compiler count | `1`
`puppetserver.compilers.autoScaling.enabled` | If true, creates compilers Horizontal Pod Autoscaler | `false`
`puppetserver.compilers.autoScaling.minCompilers` | If autoscaling enabled, this field sets minimum compiler count | `1`
`puppetserver.compilers.autoScaling.maxCompilers` | If compilers autoscaling enabled, this field sets maximum compiler count | `3`
`puppetserver.compilers.autoScaling.cpuUtilizationPercentage` | Target compilers CPU utilization percentage to scale | `75`
`puppetserver.compilers.autoScaling.memoryUtilizationPercentage` | Target compilers memory utilization percentage to scale | `75`
`puppetserver.compilers.podManagementPolicy` | puppetserver compilers statefulset pod management policy | `OrderedReady`
`puppetserver.compilers.fqdns.alternateServerNames` | puppetserver compilers alternate fqdns |``
`puppetserver.compilers.service.type` | puppetserver compilers svc type | `ClusterIP`
`puppetserver.compilers.service.ports` | puppetserver compilers svc exposed ports | `puppetserver`
`puppetserver.compilers.service.annotations`| puppetserver compilers svc annotations |``
`puppetserver.compilers.service.labels`| puppetserver compilers additional svc labels |``
`puppetserver.compilers.service.loadBalancerIP`| puppetserver compilers svc loadbalancer ip |``
`puppetserver.compilers.service.headless.ports`| puppetserver compilers headless svc loadbalancer ip |`https`
`puppetserver.compilers.service.headless.annotations`| puppetserver compilers headless svc annotations |``
`puppetserver.compilers.service.headless.labels`| puppetserver compilers additional headless svc labels |``
`puppetserver.compilers.ingress.enabled`| puppetserver compilers ingress creation enabled |`false`
`puppetserver.compilers.ingress.annotations`| puppetserver compilers ingress annotations |``
`puppetserver.compilers.ingress.extraLabels`| puppetserver compilers ingress extraLabels |``
`puppetserver.compilers.ingress.hosts`| puppetserver compilers ingress hostnames |``
`puppetserver.compilers.ingress.tls`| puppetserver compilers ingress tls configuration |``
`puppetserver.preGeneratedCertsJob.enabled` | puppetserver pre-generated certs |`false`
`puppetserver.preGeneratedCertsJob.jobDeadline` | puppetserver pre-generated certs job deadline in seconds |`60`
`puppetserver.puppeturl`| puppetserver control repo url |``
`r10k.name` | r10k component label | `r10k`
`r10k.image` | r10k img | `puppet/r10k`
`r10k.tag` | r10k img tag | `3.5.1`
`r10k.pullPolicy` | r10k img pull policy | `IfNotPresent`
`r10k.code.resources` | r10k control repo resource limits |``
`r10k.code.cronJob.schedule` | r10k control repo cron job schedule policy | `*/15 * * * *`
`r10k.code.extraArgs` | r10k control repo additional container env args |``
`r10k.code.extraEnv` | r10k control repo additional container env vars |``
`r10k.code.viaSsh.credentials.ssh.value`| r10k control repo ssh key file |``
`r10k.code.viaSsh.credentials.known_hosts.value`| r10k control repo ssh known hosts file |``
`r10k.code.viaSsh.credentials.existingSecret`| r10k control repo ssh secret that holds ssh key and known hosts files |``
`r10k.hiera.resources` | r10k hiera data resource limits |``
`r10k.hiera.cronJob.schedule` | r10k hiera data cron job schedule policy | `*/2 * * * *`
`r10k.hiera.extraArgs` | r10k hiera data additional container env args |``
`r10k.hiera.extraEnv` | r10k hiera data additional container env vars |``
`r10k.hiera.viaSsh.credentials.ssh.value`| r10k hiera data ssh key file |``
`r10k.hiera.viaSsh.credentials.known_hosts.value`| r10k hiera data ssh known hosts file |``
`r10k.hiera.viaSsh.credentials.existingSecret`| r10k hiera data ssh secret that holds ssh key and known hosts files |``
`postgres.name` | postgres component label | `postgres`
`postgres.image` | postgres img | `postgres`
`postgres.tag` | postgres img tag | `9.6.18`
`postgres.pullPolicy` | postgres img pull policy | `IfNotPresent`
`postgres.resources` | postgres resource limits |``
`postgres.extraEnv` | postgres additional container env vars |``
`puppetdb.name` | puppetdb component label | `puppetdb`
`puppetdb.image` | puppetdb img | `puppet/puppetdb`
`puppetdb.tag` | puppetdb img tag | `6.10.1`
`puppetdb.pullPolicy` | puppetdb img pull policy | `IfNotPresent`
`puppetdb.resources` | puppetdb resource limits |``
`puppetdb.extraEnv` | puppetdb additional container env vars |``
`puppetdb.credentials.username`| puppetdb username |`puppetdb`
`puppetdb.credentials.value.password`| puppetdb password |`20-char randomly generated`
`puppetdb.credentials.existingSecret`| existing k8s secret that holds puppetdb username and password |``
`puppetboard.enabled` | puppetboard availability | `false`
`puppetboard.name` | puppetboard component label | `puppetboard`
`puppetboard.image` | puppetboard img | `puppet/puppetboard`
`puppetboard.tag` | puppetboard img tag | `2.1.2`
`puppetboard.pullPolicy` | puppetboard img pull policy | `IfNotPresent`
`puppetboard.resources` | puppetboard resource limits |``
`puppetboard.extraEnv` | puppetboard additional container env vars |``
`puppetboard.ingress.enabled`| puppetboard ingress creation enabled |`false`
`puppetboard.ingress.annotations`| puppetboard ingress annotations |``
`puppetboard.ingress.extraLabels`| puppetboard ingress extraLabels |``
`puppetboard.ingress.hosts`| puppetboard ingress hostnames |``
`puppetboard.ingress.tls`| puppetboard ingress tls configuration |``
`hiera.name` | hiera component label | `hiera`
`hiera.hieradataurl`| hieradata repo url |``
`hiera.config`| hieradata yaml config |``
`hiera.eyaml.private_key`| hiera eyaml private key |``
`hiera.eyaml.public_key`| hiera eyaml public key |``
`nodeSelector`| Node labels for pod assignment |``
`affinity`| Affinity for pod assignment |``
`tolerations`| Tolerations for pod assignment |``
`priorityClass`| Leverage a priorityClass to ensure your pods survive resource shortages |``
`podAnnotations`| Extra Pod annotations |``
`storage.storageClass`| Storage Class |``
`storage.annotations`| Storage annotations |``
`storage.size`| PVCs Storage Size |`100Mi`

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
helm install --namespace puppetserver --name puppetserver puppet/puppetserver-helm-chart --set puppetserver.puppeturl='https://github.com/$SOMEUSER/puppet.git',hiera.hieradataurl='https://github.com/$SOMEUSER/hieradata.git'
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
helm install --namespace puppetserver --name puppetserver puppet/puppetserver-helm-chart -f values.yaml
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Credits

* [Miroslav Hadzhiev](mailto:miroslav.hadzhiev@gmail.com), Lead Author and Developer
* [Pupperware Team](mailto:pupperware@puppet.com), Owner
* [Sean Conley](mailto:slconley@gmail.com), Developer
* [Morgan Rhodes](mailto:morgan@puppet.com), Developer
* [Scott Cressi](mailto:scottcressi@gmail.com), Developer
