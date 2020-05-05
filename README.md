# HELM Chart for Puppet Server

## Introduction

This chart bootstraps Puppet Server and its components on a Kubernetes cluster using the Helm package manager.

## Prerequisites

### Code Repos

* You must specify your Puppet Control Repo using `puppetserver.puppeturl` variable in the `values.yaml` file or include `--set puppetserver.puppeturl=<your_public_repo>` in the command line of `helm install`. You should specify your separate Hieradata Repo as well using the `hiera.hieradataurl` variable.

* You can also use private repos. Just remember to specify your credentials using `r10k.code.viaSsh.credentials.ssh.value`. You can set similar credentials for your Hieradata Repo.

### Kubernetes Storage Class

Depending on your deployment scenario a certain `StorageClass` object might be required.
In a big K8s megacluster running in the cloud multiple labeled (and/or tainted) nodes in each Availability Zone (AZ) might be present. In such scenario Puppet Server components that use common storage (`puppetserver` and `r10k`) require their volumes to be created in the same AZ. That can be achieved through a custom `StorageClass`.

### Common Storage Required for r10k and Puppet Server

Right now we use K8s Cron job to sync the Puppet and Hiera code. We have plans to switch to a sidecar container when we release support for running multiple Puppet compile masters on different K8s nodes. Until then please take advantage of the examples for pod affinity constraint for r10k or the common storage node selector in [values.yaml](values.yaml).

### Load-Balancing Puppet Server

In case a Load Balancer (LB) must sit in front of Puppet Server - please keep in mind that having a Network LB (operating at OSI Layer 4) is preferable.

### NGINX Ingress Controller Configuration

The Ingress resource is disabled by default, but if it is enabled then ssl-passthrough must be used so that puppet agents will get the expected server certificate when connecting to the service.  This feature must be enabled on the Ingress resource itself, but also must be enabled via command line argument to the NGINX Ingress Controller.  More information on that can be found [here](<https://kubernetes.github.io/ingress-nginx/user-guide/cli-arguments/>).

## Support for Helm v2

Those of you who would like to deploy the chart with Helm v2 - please use chart version `v1.x`/`v2.x`.

## Installing the Chart

You can install the chart with the release name `puppetserver` as below.

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
`puppetserver.tag` | puppetserver img tag | `6.8.0`
`puppetserver.resources` | puppetserver resource limits | ``
`puppetserver.extraEnv` | puppetserver additional container env vars |``
`puppetserver.preGeneratedCertsJob.enabled` | puppetserver pre-generated certs |`false`
`puppetserver.preGeneratedCertsJob.jobDeadline` | puppetserver pre-generated certs job deadline in seconds |`60`
`puppetserver.pullPolicy` | puppetserver img pull policy | `IfNotPresent`
`puppetserver.multiCompilers.enabled` | If true, creates multiple Puppetserver compilers | `false`
`puppetserver.multiCompilers.manualScaling.compilers` | If multiple compilers are enabled, this field sets compiler count | `3`
`puppetserver.multiCompilers.autoScaling.enabled` | If true, creates Horizontal Pod Autoscaler | `false`
`puppetserver.multiCompilers.autoScaling.minCompilers` | If autoscaling enabled, this field sets minimum compiler count | `2`
`puppetserver.multiCompilers.autoScaling.maxCompilers` | If autoscaling enabled, this field sets maximum compiler count | `11`
`puppetserver.multiCompilers.autoScaling.cpuUtilizationPercentage` | Target CPU utilization percentage to scale | `50`
`puppetserver.multiCompilers.autoScaling.memoryUtilizationPercentage` | Target memory utilization percentage to scale | `50`
`puppetserver.fqdns.alternateServerNames` | puppetserver alternate fqdns |``
`puppetserver.service.type` | puppetserver svc type | `ClusterIP`
`puppetserver.service.ports` | puppetserver svc exposed ports | `puppetserver`
`puppetserver.service.annotations`| puppetserver svc annotations |``
`puppetserver.service.labels`| puppetserver additional svc labels |``
`puppetserver.service.loadBalancerIP`| puppetserver svc loadbalancer ip |``
`puppetserver.ingress.enabled`| puppetserver ingress creation enabled |`false`
`puppetserver.ingress.annotations`| puppetserver ingress annotations |``
`puppetserver.ingress.extraLabels`| puppetserver ingress extraLabels |``
`puppetserver.ingress.hosts`| puppetserver ingress hostnames |``
`puppetserver.ingress.tls`| puppetserver ingress tls configuration |``
`puppetserver.puppeturl`| puppetserver control repo url |``
`r10k.name` | r10k component label | `r10k`
`r10k.image` | r10k img | `puppet/r10k`
`r10k.tag` | r10k img tag | `3.3.3`
`r10k.pullPolicy` | r10k img pull policy | `IfNotPresent`
`r10k.affinity` | r10k pod assignment affinity |``
`r10k.code.cronJob.schedule` | r10k control repo cron job schedule policy | `*/15 * * * *`
`r10k.code.cronJob.concurrencyPolicy` | r10k control repo cron job concurrency policy | `Forbid`
`r10k.code.cronJob.restartPolicy` | r10k control repo cron job restart policy | `Never`
`r10k.code.cronJob.startingDeadlineSeconds` | r10k control repo cron job starting deadline | `500`
`r10k.code.cronJob.activeDeadlineSeconds` | r10k control repo cron job active deadline | `750`
`r10k.code.resources` | r10k control repo resource limits |``
`r10k.code.extraArgs` | r10k control repo additional container env args |``
`r10k.code.extraEnv` | r10k control repo additional container env vars |``
`r10k.code.viaSsh.credentials.ssh.value`| r10k control repo ssh key file |``
`r10k.code.viaSsh.credentials.known_hosts.value`| r10k control repo ssh known hosts file |``
`r10k.code.viaSsh.credentials.existingSecret`| r10k control repo ssh secret that holds ssh key and known hosts files |``
`r10k.hiera.cronJob.schedule` | r10k hiera data cron job schedule policy | `*/2 * * * *`
`r10k.hiera.cronJob.concurrencyPolicy` | r10k control repo cron job concurrency policy | `Forbid`
`r10k.hiera.cronJob.restartPolicy` | r10k control repo cron job restart policy | `Never`
`r10k.hiera.cronJob.startingDeadlineSeconds` | r10k control repo cron job starting deadline | `500`
`r10k.hiera.cronJob.activeDeadlineSeconds` | r10k control repo cron job active deadline | `750`
`r10k.hiera.resources` | r10k hiera data resource limits |``
`r10k.hiera.extraArgs` | r10k hiera data additional container env args |``
`r10k.hiera.extraEnv` | r10k hiera data additional container env vars |``
`r10k.hiera.viaSsh.credentials.ssh.value`| r10k hiera data ssh key file |``
`r10k.hiera.viaSsh.credentials.known_hosts.value`| r10k hiera data ssh known hosts file |``
`r10k.hiera.viaSsh.credentials.existingSecret`| r10k hiera data ssh secret that holds ssh key and known hosts files |``
`postgres.name` | postgres component label | `postgres`
`postgres.image` | postgres img | `postgres`
`postgres.tag` | postgres img tag | `9.6.16`
`postgres.pullPolicy` | postgres img pull policy | `IfNotPresent`
`postgres.resources` | postgres resource limits |``
`postgres.extraEnv` | postgres additional container env vars |``
`puppetdb.name` | puppetdb component label | `puppetdb`
`puppetdb.image` | puppetdb img | `puppet/puppetdb`
`puppetdb.tag` | puppetdb img tag | `6.8.1`
`puppetdb.pullPolicy` | puppetdb img pull policy | `IfNotPresent`
`puppetdb.resources` | puppetdb resource limits |``
`puppetdb.extraEnv` | puppetdb additional container env vars |``
`puppetdb.credentials.username`| puppetdb username |`puppetdb`
`puppetdb.credentials.value.password`| puppetdb password |`20-char randomly generated`
`puppetdb.credentials.existingSecret`| existing k8s secret that holds puppetdb username and password |``
`puppetboard.enabled` | puppetboard availability | `false`
`puppetboard.name` | puppetboard component label | `puppetboard`
`puppetboard.image` | puppetboard img | `puppet/puppetboard`
`puppetboard.tag` | puppetboard img tag | `0.3.0`
`puppetboard.pullPolicy` | puppetboard img pull policy | `IfNotPresent`
`puppetboard.resources` | puppetboard resource limits |``
`puppetboard.extraEnv` | puppetboard additional container env vars |``
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
`storage.selector`| PVs/PVCs Selector Config |`false`
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
* [Sean Conley](mailto:slconley@gmail.com), Developer
* [Morgan Rhodes](mailto:morgan@puppet.com), Developer
* [Scott Cressi](mailto:scottcressi@gmail.com), Developer
* [Pupperware Team](mailto:pupperware@puppet.com), Owner
