# HELM Chart for Puppet Server

## Introduction

This chart bootstraps Puppet Server and its components on a Kubernetes cluster using the Helm package manager.

## Prerequisites

### Code Repos

* You must specify your Puppet Control Repo using `puppetserver.puppeturl` variable in the `values.yaml` file or include `--set puppetserver.puppeturl=<your_public_repo>` in the command line of `helm install`. You can specify your separate Hieradata Repo as well using the `hiera.hieradataurl` variable.

* You can also use private repos. Just remember to specify your credentials using `r10k.code.viaSsh.credentials.ssh.value`. You can set similar credentials for your Hieradata Repo.

### Load-Balancing Puppet Server

In case a Load Balancer (LB) must sit in front of Puppet Server - please keep in mind that having a Network LB (operating at OSI Layer 4) is preferable.

### NGINX Ingress Controller Configuration

The Ingress resource is disabled by default, but if it is enabled then ssl-passthrough must be used so that puppet agents will get the expected server certificate when connecting to the service.  This feature must be enabled on the Ingress resource itself, but also must be enabled via command line argument to the NGINX Ingress Controller.  More information on that can be found [here](<https://kubernetes.github.io/ingress-nginx/user-guide/cli-arguments/>).

> **NOTE**: Ingress URLs must be passed in the `Values.puppetserver.masters.fqdns.alternateServerNames`. Also - in the `Values.puppetserver.compilers.fqdns.alternateServerNames` (if Puppet Compilers and their Ingress resources are deployed).

## Migrating from Bare-Metal Puppet Infrastructure

### Auto-Signing Certificate Requests

In general, the easiest way to switch the Puppet Agents from using one Puppet master to another is by enabling the auto-signing of CSRs. By default, that has been pre-enabled in the Puppet Server Docker container. It can be disabled in the Values file by passing an extra environment variable: `AUTOSIGN=false` (in `.Values.puppetserver.extraEnv`).

You will also need to remove the existing certificates in `/etc/puppetlabs/puppet/ssl` on each Puppet agent.

### Using Pre-Generated Puppet Master Certificates

If you prefer not to auto-sign or manually sign the Puppet Agents' CSRs - you can use the same Puppet master and PuppetDB certificates which you used in your bare-metal setup. Please archive into two separate files and place your certificates in the `init/puppet-certs/puppetserver` and `init/puppet-certs/puppetdb` directories and enable their usage in the Values file (`.Values.puppetserver.preGeneratedCertsJob.enabled`).

> **NOTE**: For more information please check - [README.md](init/README.md). For more general knowledge on the matter you can also read the article - <https://puppet.com/docs/puppet/5.5/ssl_regenerate_certificates.html.>

## Horizontal Scaling

To achieve better availability and higher throughput of Puppet Infrastructure, you'll need to scale out Puppet Masters and/or Puppet Compilers.

### Multiple Puppet Masters

To achieve better availability of Puppet Infrastructure, you can scale out Puppet Server Masters using `.Values.puppetserver.masters.multiMasters`. These Servers are known as masters, and are responsible for the creation and signing of your Puppet Agents' certificates. They are also responsible for receiving catalog requests from agents and synchronize the results with each other.

### Multiple Puppet Compilers

To achieve better throughput of Puppet Infrastructure, you can enable and scale out Puppet Server Compilers using `.Values.puppetserver.compilers`. These Servers are known as compile masters, and are simply additional load-balanced Puppet Servers that receive catalog requests from agents and synchronize the results with each other.

### Multiple PostgreSQL Read Replicas

To achieve better throughput of Puppet Infrastructure, you can enable and scale out PostgreSQL cluster using `.Values.postgresql.replication.enabled` and `.Values.postgresql.replication.slaveReplicas`.

## Chart Components

* Creates three deployments: Puppet Server Master/s, and PuppetDB.
* Creates three statefulsets (optional): Puppet Server Compiler/s, PostgreSQL Master, and PostgreSQL Read Replicas.
* Creates seven services that expose: Puppet Server Masters, Puppet Server Compilers (optional), PuppetDB, PostgreSQL, and Puppetboard (optional).
* Creates secrets to hold credentials for PuppetDB, PosgreSQL, and r10k.

## Installing the Chart

### Add Puppet Server Helm Repository

Before installing Puppet Server Helm chart, you need to add the [Puppet Server Helm repository](https://puppetlabs.github.io/puppetserver-helm-chart) to your Helm client as below.

```bash
helm repo add puppet https://puppetlabs.github.io/puppetserver-helm-chart
```

### Install the Chart

To install the chart with the release name `puppetserver`.

```bash
helm install --namespace puppetserver --name puppetserver puppet/puppetserver --set puppetserver.puppeturl='https://github.com/$SOMEUSER/control-repo.git'
```

> Note - If you do not specify a name, helm will select a name for you.

### Installed Components

You can use `kubectl get` to view all of the installed components.

```console
$ kubectl get --namespace puppetserver all
NAME                                                   READY   STATUS    RESTARTS   AGE
pod/puppetserver-postgresql-master-0                   1/1     Running   0          9m25s
pod/puppetserver-postgresql-slave-0                    1/1     Running   0          9m25s
pod/puppetserver-puppetdb-fc4978b6d-z9bsx              2/2     Running   0          9m25s
pod/puppetserver-puppetserver-compiler-0               2/2     Running   0          9m25s
pod/puppetserver-puppetserver-master-7b59cb946-9bwv6   2/2     Running   0          9m25s

NAME                                       TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                    AGE
service/agents-to-puppet                   ClusterIP   10.96.236.202   <none>        8140/TCP                   9m25s
service/puppet                             ClusterIP   10.96.51.23     <none>        8140/TCP                   9m25s
service/puppet-compilers                   ClusterIP   10.96.185.43    <none>        8140/TCP                   9m25s
service/puppet-compilers-headless          ClusterIP   None            <none>        443/TCP                    9m25s
service/puppetdb                           ClusterIP   10.96.160.91    <none>        8080/TCP,8081/TCP,80/TCP   9m25s
service/puppetserver-postgresql            ClusterIP   10.96.48.166    <none>        5432/TCP                   9m25s
service/puppetserver-postgresql-headless   ClusterIP   None            <none>        5432/TCP                   9m25s
service/puppetserver-postgresql-read       ClusterIP   10.96.219.155   <none>        5432/TCP                   9m25s

NAME                                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/puppetserver-puppetdb              1/1     1            1           9m25s
deployment.apps/puppetserver-puppetserver-master   1/1     1            1           9m25s

NAME                                                         DESIRED   CURRENT   READY   AGE
replicaset.apps/puppetserver-puppetdb-fc4978b6d              1         1         1       9m25s
replicaset.apps/puppetserver-puppetserver-master-7b59cb946   1         1         1       9m25s

NAME                                                  READY   AGE
statefulset.apps/puppetserver-postgresql-master       1/1     9m25s
statefulset.apps/puppetserver-postgresql-slave        1/1     9m25s
statefulset.apps/puppetserver-puppetserver-compiler   1/1     9m25s

NAME                                                                    REFERENCE                                         TARGETS                        MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/puppetserver-compilers-autoscaler   StatefulSet/puppetserver-puppetserver-compilers   33%/75%, 47%/75%               1         3         0          9m25s
```

## Configuration

The following table lists the configurable parameters of the Puppetserver chart and their default values.

| Parameter | Description | Default|
| --------- | ----------- | -------|
| `puppetserver.name` | puppetserver component label | `puppetserver`|
| `puppetserver.image` | puppetserver image | `puppet/puppetserver`|
| `puppetserver.tag` | puppetserver img tag | `6.12.1`|
| `puppetserver.pullPolicy` | puppetserver img pull policy | `IfNotPresent`|
| `puppetserver.masters.resources` | puppetserver masters resource limits | ``|
| `puppetserver.masters.extraEnv` | puppetserver masters additional container env vars |``|
| `puppetserver.masters.readinessProbeInitialDelay` | the initial delay for the puppetserver masters readiness probe | `180`|
| `puppetserver.masters.readinessProbePeriodSeconds` | how often (in seconds) to perform the puppetserver masters readiness probe | `60`|
| `puppetserver.masters.readinessProbeTimeout` | the timeout for the puppetserver masters readiness probe | `20`|
| `puppetserver.masters.readinessProbeFailureThreshold` | the failure threshold for the puppetserver masters readiness probe | `3`|
| `puppetserver.masters.readinessProbeSuccessThreshold` | the success threshold for the puppetserver masters readiness probe | `1`|
| `puppetserver.masters.livenessProbeInitialDelay` | the initial delay for the puppetserver masters liveness probe | `420`|
| `puppetserver.masters.livenessProbePeriodSeconds` | how often (in seconds) to perform the puppetserver masters liveness probe | `30`|
| `puppetserver.masters.livenessProbeTimeout` | the timeout for the puppetserver masters liveness probe  | `10`|
| `puppetserver.masters.livenessProbeFailureThreshold` | the failure threshold for the puppetserver masters liveness probe | `3`|
| `puppetserver.masters.livenessProbeSuccessThreshold` | the success threshold for the puppetserver masters liveness probe | `1`|
| `puppetserver.masters.fqdns.alternateServerNames` | puppetserver masters alternate fqdns |``|
| `puppetserver.masters.service.type` | puppetserver masters svc type | `ClusterIP`|
| `puppetserver.masters.service.ports` | puppetserver masters svc exposed ports | `puppetserver`|
| `puppetserver.masters.service.annotations`| puppetserver masters svc annotations |``|
| `puppetserver.masters.service.labels`| puppetserver additional masters svc labels |``|
| `puppetserver.masters.service.loadBalancerIP`| puppetserver masters svc loadbalancer ip |``|
| `puppetserver.masters.ingress.enabled`| puppetserver masters ingress creation enabled |`false`|
| `puppetserver.masters.ingress.annotations`| puppetserver masters ingress annotations |``|
| `puppetserver.masters.ingress.extraLabels`| puppetserver masters ingress extraLabels |``|
| `puppetserver.masters.ingress.hosts`| puppetserver masters ingress hostnames |``|
| `puppetserver.masters.ingress.tls`| puppetserver masters ingress tls configuration |``|
| `puppetserver.masters.multiMasters.enabled` | If true, creates multiple Puppetserver masters | `false`|
| `puppetserver.masters.multiMasters.manualScaling.masters` | If multiple masters are enabled, this field sets masters count | `1`|
| `puppetserver.masters.multiMasters.autoScaling.enabled` | If true, creates masters Horizontal Pod Autoscaler | `false`|
| `puppetserver.masters.multiMasters.autoScaling.minMasters` | If masters autoscaling enabled, this field sets minimum masters count | `1`|
| `puppetserver.masters.multiMasters.autoScaling.maxMasters` | If masters autoscaling enabled, this field sets maximum masters count | `3`|
| `puppetserver.masters.multiMasters.autoScaling.cpuUtilizationPercentage` | Target masters CPU utilization percentage to scale | `75`|
| `puppetserver.masters.multiMasters.autoScaling.memoryUtilizationPercentage` | Target masters memory utilization percentage to scale | `75`|
| `puppetserver.masters.customPersistentVolumeClaim.puppet.enable`| If true, use custom PVC for puppet |``|
| `puppetserver.masters.customPersistentVolumeClaim.puppet.config `| Configuration for custom PVC for puppet |``|
| `puppetserver.masters.customPersistentVolumeClaim.code.enable`| If true, use custom PVC for code  |``|
| `puppetserver.masters.customPersistentVolumeClaim.code.config `| Configuration for custom PVC for code |``|
| `puppetserver.masters.customPersistentVolumeClaim.serverdata.enable`| If true, use custom PVC for serverdata  |``|
| `puppetserver.masters.customPersistentVolumeClaim.serverdata.config `| Configuration for custom PVC for serverdata |``|
| `puppetserver.compilers.enabled` | If true, creates Puppetserver compilers | `false`|
| `puppetserver.compilers.resources` | puppetserver compilers resource limits |``|
| `puppetserver.compilers.podAntiAffinity` | puppetserver compilers pod affinity constraints |`false`|
| `puppetserver.compilers.annotations`| puppetserver compilers statefulset annotations |``|
| `puppetserver.compilers.extraEnv` | puppetserver compilers additional container env vars |``|
| `puppetserver.compilers.readinessProbeInitialDelay` | the initial delay for the puppetserver masters readiness probe | `180`|
| `puppetserver.compilers.readinessProbePeriodSeconds` | how often (in seconds) to perform the puppetserver masters readiness probe | `60`|
| `puppetserver.compilers.readinessProbeTimeout` | the timeout for the puppetserver masters readiness probe | `20`|
| `puppetserver.compilers.readinessProbeFailureThreshold` | the failure threshold for the puppetserver masters readiness probe | `3`|
| `puppetserver.compilers.readinessProbeSuccessThreshold` | the success threshold for the puppetserver masters readiness probe | `1`|
| `puppetserver.compilers.livenessProbeInitialDelay` | the initial delay for the puppetserver masters liveness probe | `420`|
| `puppetserver.compilers.livenessProbePeriodSeconds` | how often (in seconds) to perform the puppetserver masters liveness probe | `30`|
| `puppetserver.compilers.livenessProbeTimeout` | the timeout for the puppetserver masters liveness probe  | `10`|
| `puppetserver.compilers.livenessProbeFailureThreshold` | the failure threshold for the puppetserver masters liveness probe | `3`|
| `puppetserver.compilers.livenessProbeSuccessThreshold` | the success threshold for the puppetserver masters liveness probe | `1`|
| `puppetserver.compilers.manualScaling.compilers` | If multiple compilers are enabled, this field sets compiler count | `1`|
| `puppetserver.compilers.autoScaling.enabled` | If true, creates compilers Horizontal Pod Autoscaler | `false`|
| `puppetserver.compilers.autoScaling.minCompilers` | If autoscaling enabled, this field sets minimum compiler count | `1`|
| `puppetserver.compilers.autoScaling.maxCompilers` | If compilers autoscaling enabled, this field sets maximum compiler count | `3`|
| `puppetserver.compilers.autoScaling.cpuUtilizationPercentage` | Target compilers CPU utilization percentage to scale | `75`|
| `puppetserver.compilers.autoScaling.memoryUtilizationPercentage` | Target compilers memory utilization percentage to scale | `75`|
| `puppetserver.compilers.podManagementPolicy` | puppetserver compilers statefulset pod management policy | `OrderedReady`|
| `puppetserver.compilers.fqdns.alternateServerNames` | puppetserver compilers alternate fqdns |``|
| `puppetserver.compilers.service.type` | puppetserver compilers svc type | `ClusterIP`|
| `puppetserver.compilers.service.ports` | puppetserver compilers svc exposed ports | `puppetserver`|
| `puppetserver.compilers.service.annotations`| puppetserver compilers svc annotations |``|
| `puppetserver.compilers.service.labels`| puppetserver compilers additional svc labels |``|
| `puppetserver.compilers.service.loadBalancerIP`| puppetserver compilers svc loadbalancer ip |``|
| `puppetserver.compilers.service.headless.ports`| puppetserver compilers headless svc loadbalancer ip |`https`|
| `puppetserver.compilers.service.headless.annotations`| puppetserver compilers headless svc annotations |``|
| `puppetserver.compilers.service.headless.labels`| puppetserver compilers additional headless svc labels |``|
| `puppetserver.compilers.ingress.enabled`| puppetserver compilers ingress creation enabled |`false`|
| `puppetserver.compilers.ingress.annotations`| puppetserver compilers ingress annotations |``|
| `puppetserver.compilers.ingress.extraLabels`| puppetserver compilers ingress extraLabels |``|
| `puppetserver.compilers.ingress.hosts`| puppetserver compilers ingress hostnames |``|
| `puppetserver.compilers.ingress.tls`| puppetserver compilers ingress tls configuration |``|
| `puppetserver.preGeneratedCertsJob.enabled` | puppetserver pre-generated certs |`false`|
| `puppetserver.preGeneratedCertsJob.jobDeadline` | puppetserver pre-generated certs job deadline in seconds |`60`|
| `puppetserver.puppeturl`| puppetserver control repo url |``|
| `r10k.name` | r10k component label | `r10k`|
| `r10k.image` | r10k img | `puppet/r10k`|
| `r10k.tag` | r10k img tag | `3.5.1`|
| `r10k.pullPolicy` | r10k img pull policy | `IfNotPresent`|
| `r10k.code.resources` | r10k control repo resource limits |``|
| `r10k.code.cronJob.schedule` | r10k control repo cron job schedule policy | `*/15 * * * *`|
| `r10k.code.extraArgs` | r10k control repo additional container env args |``|
| `r10k.code.extraEnv` | r10k control repo additional container env vars |``|
| `r10k.code.viaSsh.credentials.ssh.value`| r10k control repo ssh key file |``|
| `r10k.code.viaSsh.credentials.known_hosts.value`| r10k control repo ssh known hosts file |``|
| `r10k.code.viaSsh.credentials.existingSecret`| r10k control repo ssh secret that holds ssh key and known hosts files |``|
| `r10k.hiera.resources` | r10k hiera data resource limits |``|
| `r10k.hiera.cronJob.schedule` | r10k hiera data cron job schedule policy | `*/2 * * * *`|
| `r10k.hiera.extraArgs` | r10k hiera data additional container env args |``|
| `r10k.hiera.extraEnv` | r10k hiera data additional container env vars |``|
| `r10k.hiera.viaSsh.credentials.ssh.value`| r10k hiera data ssh key file |``|
| `r10k.hiera.viaSsh.credentials.known_hosts.value`| r10k hiera data ssh known hosts file |``|
| `r10k.hiera.viaSsh.credentials.existingSecret`| r10k hiera data ssh secret that holds ssh key and known hosts files |``|
| `postgresql.enabled` | postgres deployment as puppetdb backend | `true`|
| `postgresql.name` | postgres component label | `postgresql`|
| `postgresql.resources` | postgres resource limits |``|
| `postgresql.postgresqlDatabase` | postgres database name |`puppetdb`|
| `postgresql.initdbUser` | postgres username to run initdb scripts at first boot |`postgres`|
| `postgresql.initdbScriptsConfigMap` | postgres initdb scripts run at first boot |`postgresql-custom-extensions`|
| `postgresql.persistence.enabled` | postgres database persistence |`true`|
| `postgresql.persistence.existingClaim` | postgres manually managed pvc |``|
| `postgresql.persistence.size` | postgres persistence pvc size |`10Gi`|
| `postgresql.persistence.annotations` | postgres persistence resource policy via annotations |`keep`|
| `postgresql.replication.enabled` | postgres replication availability |`false`|
| `postgresql.replication.slaveReplicas` | postgres replication slave replicas |`1`|
| `puppetdb.name` | puppetdb component label | `puppetdb`|
| `puppetdb.image` | puppetdb img | `puppet/puppetdb`|
| `puppetdb.tag` | puppetdb img tag | `6.12.0`|
| `puppetdb.pullPolicy` | puppetdb img pull policy | `IfNotPresent`|
| `puppetdb.resources` | puppetdb resource limits |``|
| `puppetdb.extraEnv` | puppetdb additional container env vars |``|
| `puppetdb.metrics.enabled` | puppetdb metrics enable/disable flag |`false`|
| `puppetdb.customPersistentVolumeClaim.storage.enable`| If true, use custom PVC for storage |``|
| `puppetdb.customPersistentVolumeClaim.storage.config `| Configuration for custom PVC for storage |``|
| `puppetboard.enabled` | puppetboard availability | `false`|
| `puppetboard.name` | puppetboard component label | `puppetboard`|
| `puppetboard.image` | puppetboard img | `xtigyro/puppetboard`|
| `puppetboard.tag` | puppetboard img tag | `2.1.2`|
| `puppetboard.pullPolicy` | puppetboard img pull policy | `IfNotPresent`|
| `puppetboard.resources` | puppetboard resource limits |``|
| `puppetboard.extraEnv` | puppetboard additional container env vars |``|
| `puppetboard.ingress.enabled`| puppetboard ingress creation enabled |`false`|
| `puppetboard.ingress.annotations`| puppetboard ingress annotations |``|
| `puppetboard.ingress.extraLabels`| puppetboard ingress extraLabels |``|
| `puppetboard.ingress.hosts`| puppetboard ingress hostnames |``|
| `puppetboard.ingress.tls`| puppetboard ingress tls configuration |``|
| `hiera.name` | hiera component label | `hiera`|
| `hiera.hieradataurl`| hieradata repo url |``|
| `hiera.config`| hieradata yaml config |``|
| `hiera.eyaml.private_key`| hiera eyaml private key |``|
| `hiera.eyaml.public_key`| hiera eyaml public key |``|
| `global.credentials.username`| puppetdb and postgresql username |`puppetdb`|
| `global.credentials.password`| puppetdb and postgresql password |`unbreakablePassword`|
| `global.credentials.existingSecret`| existing k8s secret that holds puppetdb and postgresql username and password |``|
| `nameOverride`| puppetserver components name for `component:` labels |``|
| `nodeSelector`| Node labels for pod assignment |``|
| `affinity`| Affinity for pod assignment |``|
| `tolerations`| Tolerations for pod assignment |``|
| `priorityClass`| Leverage a priorityClass to ensure your pods survive resource shortages |``|
| `podAnnotations`| Extra Pod annotations |``|
| `storage.accessModes`| Storage Access Modes (expects array) |`["ReadWriteOnce"]`|
| `storage.storageClass`| Storage Class |``|
| `storage.annotations`| Storage annotations |``|
| `storage.size`| PVCs Storage Size |`400Mi`|

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
helm install --namespace puppetserver --name puppetserver puppet/puppetserver --set puppetserver.puppeturl='https://github.com/$SOMEUSER/puppet.git',hiera.hieradataurl='https://github.com/$SOMEUSER/hieradata.git'
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```bash
helm install --namespace puppetserver --name puppetserver puppet/puppetserver -f values.yaml
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Testing the Deployed Chart Resources

```bash
kubectl port-forward -n puppetserver svc/agents-to-puppet 8140:8140 &
kubectl port-forward -n puppetserver svc/puppet-compilers 8141:8140 &

TIME_NOW="$(date +"%Y%m%dT%H%M")"
cp "/etc/hosts"{,.backup_"$TIME_NOW"}
echo '127.0.0.1 puppet agents-to-puppet puppet-compilers' >> /etc/hosts
# if Ingress is used, e.g.
# INGRESS_IP="$(kubectl -n puppetserver get ingress | grep '\-masters' | tr -s " " | cut -d' ' -f4 | cut -d',' -f1)"
# echo "$INGRESS_IP" puppet.local.masters puppet.local.compilers >> /etc/hosts

docker run -dit --network host --name goofy_xtigyro --entrypoint /bin/bash puppet/puppet-agent
docker exec -it goofy_xtigyro bash
puppet agent -t --server puppet --masterport 8140 --waitforcert 15 --summarize --certname ubuntu-goofy_xtigyro
puppet agent -t --server puppet-compilers --ca_server agents-to-puppet --masterport 8141 --ca_port 8140 --summarize --certname ubuntu-goofy_xtigyro
# if Ingress is used, e.g.
# puppet agent -t --server puppet.local.compilers --ca_server puppet.local.masters --masterport 443 --ca_port 443 --summarize --certname ubuntu-goofy_xtigyro
puppet agent -t --server puppet-compilers --masterport 8141 --summarize --certname ubuntu-goofy_xtigyro
exit
docker rm -f goofy_xtigyro

docker run -dit --network host --name buggy_xtigyro --entrypoint /bin/bash puppet/puppet-agent
docker exec -it buggy_xtigyro bash
puppet agent -t --server puppet-compilers --ca_server agents-to-puppet --masterport 8141 --ca_port 8140 --summarize --certname ubuntu-buggy_xtigyro
puppet agent -t --server puppet-compilers --masterport 8141 --summarize --certname ubuntu-buggy_xtigyro
# if Ingress is used, e.g.
# puppet agent -t --server puppet.local.compilers --ca_server puppet.local.masters --masterport 443 --ca_port 443 --summarize --certname ubuntu-buggy_xtigyro
puppet agent -t --server puppet --masterport 8140 --waitforcert 15 --summarize --certname ubuntu-buggy_xtigyro
exit
docker rm -f buggy_xtigyro

yes | mv "/etc/hosts.backup_"$TIME_NOW"" "/etc/hosts"
unset TIME_NOW

jobs | grep 'port-forward' | grep 'puppetserver'
# [1]+  Running                 kubectl port-forward -n puppetserver svc/puppet 8140:8140 &
kill %[job_numbers_above]
```

## Credits

* [Miroslav Hadzhiev](https://www.linkedin.com/in/mehadzhiev/), Lead Author and Owner
* [Pupperware Team](mailto:pupperware@puppet.com), Co-Author and Owner
* [Morgan Rhodes](mailto:morgan@puppet.com), Maintainer
* [Sean Conley](https://www.linkedin.com/in/seanconley/), Maintainer
* [Scott Cressi](https://www.linkedin.com/in/scottcressi/), Co-Author
* [Kai Sisterhenn](https://www.sistason.de/), Contributor
* [chwehrli](https://github.com/chwehrli), Contributor
* [Niels Højen](https://github.com/nielshojen), Contributor
* [Hryhorii Didenko](https://github.com/HryhoriiDidenko), Contributor
* [John Stewart](https://github.com/jstewart612), Contributor
* [Erlon Pinheiro](https://github.com/erlonpinheiro), Contributor
