# Changelog

## [Unreleased](https://github.com/puppetlabs/puppetserver-helm-chart/tree/HEAD)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.14.0...HEAD)

**Fixed bugs:**

- R10k stop responding causing continues deployments to be halted [\#102](https://github.com/puppetlabs/puppetserver-helm-chart/issues/102)

## [v5.14.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.14.0) (2022-02-10)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.13.0...v5.14.0)

**Implemented enhancements:**

- Allow to set PVC option volumeBindingMode [\#100](https://github.com/puppetlabs/puppetserver-helm-chart/issues/100)

**Merged pull requests:**

- Update Components to Latest Versions [\#98](https://github.com/puppetlabs/puppetserver-helm-chart/pull/98) ([Xtigyro](https://github.com/Xtigyro))

## [v5.13.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.13.0) (2021-11-29)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.12.0...v5.13.0)

**Merged pull requests:**

- feat\(eyaml\): allow more than one pub/priv keypair in existing eyaml key map [\#99](https://github.com/puppetlabs/puppetserver-helm-chart/pull/99) ([raphink](https://github.com/raphink))

## [v5.12.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.12.0) (2021-09-21)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.11.0...v5.12.0)

**Merged pull requests:**

- Add Support for Ingress pathType and ingressClassName. Bump Puppetserver and PuppetDB Versions to Latest. Allow KubeVersion To Be Overridden. [\#97](https://github.com/puppetlabs/puppetserver-helm-chart/pull/97) ([Xtigyro](https://github.com/Xtigyro))

## [v5.11.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.11.0) (2021-08-31)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.10.0...v5.11.0)

**Merged pull requests:**

- set securityContext for puppetboard container [\#96](https://github.com/puppetlabs/puppetserver-helm-chart/pull/96) ([skoef](https://github.com/skoef))

## [v5.10.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.10.0) (2021-08-30)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.9.0...v5.10.0)

**Merged pull requests:**

- allow to expose puppetdb service outside of the kubernetes cluster [\#95](https://github.com/puppetlabs/puppetserver-helm-chart/pull/95) ([skoef](https://github.com/skoef))

## [v5.9.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.9.0) (2021-08-12)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.8.0...v5.9.0)

**Merged pull requests:**

- allow to override PUPPETDB\_POSTGRES\_HOSTNAME for puppetdb container [\#94](https://github.com/puppetlabs/puppetserver-helm-chart/pull/94) ([skoef](https://github.com/skoef))

## [v5.8.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.8.0) (2021-07-24)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.7.0...v5.8.0)

**Merged pull requests:**

- r10k: extra settings + https credentials support [\#90](https://github.com/puppetlabs/puppetserver-helm-chart/pull/90) ([raphink](https://github.com/raphink))

## [v5.7.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.7.0) (2021-07-22)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.6.2...v5.7.0)

**Merged pull requests:**

- update to new api version of ingress \(v1.19+\) [\#91](https://github.com/puppetlabs/puppetserver-helm-chart/pull/91) ([h-phil](https://github.com/h-phil))

## [v5.6.2](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.6.2) (2021-07-21)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.6.1...v5.6.2)

**Merged pull requests:**

- puppetboard prefix [\#89](https://github.com/puppetlabs/puppetserver-helm-chart/pull/89) ([raphink](https://github.com/raphink))

## [v5.6.1](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.6.1) (2021-07-20)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.6.0...v5.6.1)

**Fixed bugs:**

- Wrong parameter name in README to disable autosign [\#79](https://github.com/puppetlabs/puppetserver-helm-chart/issues/79)

**Merged pull requests:**

- fix: use correct puppetdb certs in puppetboard & persist puppet ca [\#88](https://github.com/puppetlabs/puppetserver-helm-chart/pull/88) ([raphink](https://github.com/raphink))

## [v5.6.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.6.0) (2021-05-01)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.5.0...v5.6.0)

**Implemented enhancements:**

- Update Components. Small Fixes and Tweaks. [\#87](https://github.com/puppetlabs/puppetserver-helm-chart/pull/87) ([Xtigyro](https://github.com/Xtigyro))

## [v5.5.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.5.0) (2021-04-30)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.4.0...v5.5.0)

**Merged pull requests:**

- PuppetDB/Puppetboard: fix containers syntax and allow alternate containerPort [\#86](https://github.com/puppetlabs/puppetserver-helm-chart/pull/86) ([raphink](https://github.com/raphink))

## [v5.4.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.4.0) (2021-04-26)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.3.0...v5.4.0)

**Implemented enhancements:**

- Use official Puppetboard image, use port 9090, and allow extra PuppetDB containers. [\#84](https://github.com/puppetlabs/puppetserver-helm-chart/pull/84) ([raphink](https://github.com/raphink))

## [v5.3.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.3.0) (2021-04-22)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.2.0...v5.3.0)

**Implemented enhancements:**

- Change the order how env block is built [\#83](https://github.com/puppetlabs/puppetserver-helm-chart/pull/83) ([erlonpinheiro](https://github.com/erlonpinheiro))

## [v5.2.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.2.0) (2021-03-29)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.1.0...v5.2.0)

**Implemented enhancements:**

- Configurable accessModes for persistence [\#80](https://github.com/puppetlabs/puppetserver-helm-chart/issues/80)

**Merged pull requests:**

- feat\(accessModes\): make it a configurable parameter for chart PVCs [\#82](https://github.com/puppetlabs/puppetserver-helm-chart/pull/82) ([jstewart612](https://github.com/jstewart612))

## [v5.1.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.1.0) (2021-02-10)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.0.4...v5.1.0)

**Fixed bugs:**

- Error puppetboard - java.lang.Exception : No access from client \<ip-address\> allowed [\#72](https://github.com/puppetlabs/puppetserver-helm-chart/issues/72)

**Merged pull requests:**

- \[gh-actions\] Replace "set-env". Replace "OWNERS". [\#78](https://github.com/puppetlabs/puppetserver-helm-chart/pull/78) ([Xtigyro](https://github.com/Xtigyro))
- \(maint\) Add CODEOWNERS [\#77](https://github.com/puppetlabs/puppetserver-helm-chart/pull/77) ([mwaggett](https://github.com/mwaggett))
- Update CHANGELOG.md for v5.1.0 [\#76](https://github.com/puppetlabs/puppetserver-helm-chart/pull/76) ([Xtigyro](https://github.com/Xtigyro))
- Added the ability to use custom PVC  [\#75](https://github.com/puppetlabs/puppetserver-helm-chart/pull/75) ([HryhoriiDidenko](https://github.com/HryhoriiDidenko))

## [v5.0.4](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.0.4) (2020-11-02)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.0.3...v5.0.4)

**Fixed bugs:**

- r10k\_code\_cronjob.sh and r10k\_hiera\_cronjob.sh might not be generated properly. [\#70](https://github.com/puppetlabs/puppetserver-helm-chart/issues/70)

**Merged pull requests:**

- Fixed issue \# 72 - Puppetboard showing "internal server 500" [\#73](https://github.com/puppetlabs/puppetserver-helm-chart/pull/73) ([pjamenaja](https://github.com/pjamenaja))

## [v5.0.3](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.0.3) (2020-11-01)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.0.2...v5.0.3)

**Merged pull requests:**

- Fixed issue \#70 - r10k and hiera cron script [\#71](https://github.com/puppetlabs/puppetserver-helm-chart/pull/71) ([pjamenaja](https://github.com/pjamenaja))

## [v5.0.2](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.0.2) (2020-10-31)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.0.1...v5.0.2)

**Merged pull requests:**

- Fix for "DNS\_ALT\_NAMES" for Non-Compiler Deployments [\#74](https://github.com/puppetlabs/puppetserver-helm-chart/pull/74) ([Xtigyro](https://github.com/Xtigyro))

## [v5.0.1](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.0.1) (2020-09-18)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v5.0.0...v5.0.1)

**Merged pull requests:**

- Fixes for Resource Names of HorizontalPodAutoscaler. README Updates. [\#69](https://github.com/puppetlabs/puppetserver-helm-chart/pull/69) ([Xtigyro](https://github.com/Xtigyro))

## [v5.0.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v5.0.0) (2020-09-18)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v4.4.0...v5.0.0)

**Implemented enhancements:**

- Register Puppetserver Helm Chart on Kubeapps Hub [\#67](https://github.com/puppetlabs/puppetserver-helm-chart/issues/67)

**Merged pull requests:**

- \(maint\) Work around issue where all the dates in the index are overwritten [\#68](https://github.com/puppetlabs/puppetserver-helm-chart/pull/68) ([underscorgan](https://github.com/underscorgan))
- Add High-Availability and Read Replicas Support for PostgreSQL [\#66](https://github.com/puppetlabs/puppetserver-helm-chart/pull/66) ([Xtigyro](https://github.com/Xtigyro))

## [v4.4.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v4.4.0) (2020-08-26)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v4.3.0...v4.4.0)

**Merged pull requests:**

- \[v4.4.0\] Allow for changing the default Puppet Server ports for Masters and Compilers [\#64](https://github.com/puppetlabs/puppetserver-helm-chart/pull/64) ([Xtigyro](https://github.com/Xtigyro))
- \(maint\) Add a github action for on-demand chart releases [\#61](https://github.com/puppetlabs/puppetserver-helm-chart/pull/61) ([underscorgan](https://github.com/underscorgan))

## [v4.3.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v4.3.0) (2020-07-23)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v4.2.1...v4.3.0)

**Merged pull requests:**

- Chart V4.3.0 [\#60](https://github.com/puppetlabs/puppetserver-helm-chart/pull/60) ([Xtigyro](https://github.com/Xtigyro))

## [v4.2.1](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v4.2.1) (2020-07-09)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v4.2.0...v4.2.1)

**Merged pull requests:**

- Align CHANGELOG and Chart.yaml for v4.2.1 [\#55](https://github.com/puppetlabs/puppetserver-helm-chart/pull/55) ([Xtigyro](https://github.com/Xtigyro))
- Update puppetserver-ingress-masters.yaml [\#53](https://github.com/puppetlabs/puppetserver-helm-chart/pull/53) ([nielshojen](https://github.com/nielshojen))

## [v4.2.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v4.2.0) (2020-06-23)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v4.1.1...v4.2.0)

**Merged pull requests:**

- Helm v2 Backward Compatibility [\#51](https://github.com/puppetlabs/puppetserver-helm-chart/pull/51) ([Xtigyro](https://github.com/Xtigyro))

## [v4.1.1](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v4.1.1) (2020-06-22)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v4.1.0...v4.1.1)

**Merged pull requests:**

- Small adjustments in `README` for new chart app name and new default Puppetboard Img Owner [\#47](https://github.com/puppetlabs/puppetserver-helm-chart/pull/47) ([Xtigyro](https://github.com/Xtigyro))

## [v4.1.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v4.1.0) (2020-06-22)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v4.0.0...v4.1.0)

**Merged pull requests:**

- Rework Puppetboard Support [\#45](https://github.com/puppetlabs/puppetserver-helm-chart/pull/45) ([Xtigyro](https://github.com/Xtigyro))

## [v4.0.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v4.0.0) (2020-06-16)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v3.0.2...v4.0.0)

**Merged pull requests:**

- Multiple Puppetserver Compilers \(Optionally\) on Different K8s Nodes [\#41](https://github.com/puppetlabs/puppetserver-helm-chart/pull/41) ([Xtigyro](https://github.com/Xtigyro))

## [v3.0.2](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v3.0.2) (2020-05-01)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.8.4...v3.0.2)

**Merged pull requests:**

- Add Puppet Repo Instruction to `README` [\#39](https://github.com/puppetlabs/puppetserver-helm-chart/pull/39) ([Xtigyro](https://github.com/Xtigyro))

## [v1.8.4](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.8.4) (2020-05-01)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v3.0.1...v1.8.4)

## [v3.0.1](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v3.0.1) (2020-05-01)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.8.3...v3.0.1)

**Merged pull requests:**

- Reflect the New GitHub Repo and Contact Details [\#37](https://github.com/puppetlabs/puppetserver-helm-chart/pull/37) ([Xtigyro](https://github.com/Xtigyro))

## [v1.8.3](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.8.3) (2020-04-08)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v3.0.0...v1.8.3)

## [v3.0.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v3.0.0) (2020-04-07)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.8.2...v3.0.0)

**Implemented enhancements:**

- Helm v3 Support [\#36](https://github.com/puppetlabs/puppetserver-helm-chart/pull/36) ([Xtigyro](https://github.com/Xtigyro))

## [v1.8.2](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.8.2) (2020-03-24)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.8.1...v1.8.2)

**Merged pull requests:**

- Better default auto-scaling and resource limits values for Puppetserver [\#35](https://github.com/puppetlabs/puppetserver-helm-chart/pull/35) ([Xtigyro](https://github.com/Xtigyro))

## [v1.8.1](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.8.1) (2020-03-21)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.8.0...v1.8.1)

**Merged pull requests:**

- Fix Auto-Scaling of Puppetserver [\#34](https://github.com/puppetlabs/puppetserver-helm-chart/pull/34) ([Xtigyro](https://github.com/Xtigyro))

## [v1.8.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.8.0) (2020-03-16)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.7.2...v1.8.0)

**Merged pull requests:**

- Prepare for Releasing Chart's v1.8.0 [\#33](https://github.com/puppetlabs/puppetserver-helm-chart/pull/33) ([Xtigyro](https://github.com/Xtigyro))
- better distinction between storage selectors [\#32](https://github.com/puppetlabs/puppetserver-helm-chart/pull/32) ([slconley](https://github.com/slconley))

## [v1.7.2](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.7.2) (2020-02-11)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.7.1...v1.7.2)

**Merged pull requests:**

- Chart v1.7.2 [\#30](https://github.com/puppetlabs/puppetserver-helm-chart/pull/30) ([Xtigyro](https://github.com/Xtigyro))

## [v1.7.1](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.7.1) (2020-02-02)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.7.0...v1.7.1)

**Merged pull requests:**

- Improve `Chart.yaml`. Bump Component Versions. [\#29](https://github.com/puppetlabs/puppetserver-helm-chart/pull/29) ([Xtigyro](https://github.com/Xtigyro))

## [v1.7.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.7.0) (2020-01-28)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.6.6...v1.7.0)

**Merged pull requests:**

- Chart v1.7.0 [\#28](https://github.com/puppetlabs/puppetserver-helm-chart/pull/28) ([Xtigyro](https://github.com/Xtigyro))

## [v1.6.6](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.6.6) (2020-01-09)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.6.5...v1.6.6)

**Merged pull requests:**

- Fix Outdated r10k Exemplary Variable in README [\#27](https://github.com/puppetlabs/puppetserver-helm-chart/pull/27) ([Xtigyro](https://github.com/Xtigyro))

## [v1.6.5](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.6.5) (2020-01-04)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.6.4...v1.6.5)

**Merged pull requests:**

- Fixes for Helm Packaging [\#26](https://github.com/puppetlabs/puppetserver-helm-chart/pull/26) ([Xtigyro](https://github.com/Xtigyro))

## [v1.6.4](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.6.4) (2020-01-04)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.6.3...v1.6.4)

**Merged pull requests:**

- Corrections and additional info for use of Ingress resource [\#25](https://github.com/puppetlabs/puppetserver-helm-chart/pull/25) ([slconley](https://github.com/slconley))

## [v1.6.3](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.6.3) (2020-01-03)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.6.2...v1.6.3)

**Merged pull requests:**

- Allow for using the chart as a chart package [\#24](https://github.com/puppetlabs/puppetserver-helm-chart/pull/24) ([Xtigyro](https://github.com/Xtigyro))

## [v1.6.2](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.6.2) (2020-01-02)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.6.1...v1.6.2)

**Merged pull requests:**

- Puppetserver Service Improvements [\#23](https://github.com/puppetlabs/puppetserver-helm-chart/pull/23) ([Xtigyro](https://github.com/Xtigyro))

## [v1.6.1](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.6.1) (2019-12-31)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.6.0...v1.6.1)

**Merged pull requests:**

- Add Values File Comments for Puppetserver Service [\#22](https://github.com/puppetlabs/puppetserver-helm-chart/pull/22) ([Xtigyro](https://github.com/Xtigyro))

## [v1.6.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.6.0) (2019-12-27)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.5.3...v1.6.0)

**Implemented enhancements:**

- This is what I had to adjust to get it up and running on an Azure AKS cluster [\#20](https://github.com/puppetlabs/puppetserver-helm-chart/pull/20) ([chwehrli](https://github.com/chwehrli))

**Merged pull requests:**

- Add Comments for "r10k" optional affinity for pod assignment. Security Fixes. [\#21](https://github.com/puppetlabs/puppetserver-helm-chart/pull/21) ([Xtigyro](https://github.com/Xtigyro))

## [v1.5.3](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.5.3) (2019-12-07)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.5.2...v1.5.3)

**Merged pull requests:**

- Small README Fixes and One Addition. [\#19](https://github.com/puppetlabs/puppetserver-helm-chart/pull/19) ([Xtigyro](https://github.com/Xtigyro))

## [v1.5.2](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.5.2) (2019-12-06)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.5.1...v1.5.2)

**Merged pull requests:**

- Chart v1.5.2 [\#18](https://github.com/puppetlabs/puppetserver-helm-chart/pull/18) ([Xtigyro](https://github.com/Xtigyro))

## [v1.5.1](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.5.1) (2019-12-03)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.5.0...v1.5.1)

**Fixed bugs:**

- r10k credentials for https [\#9](https://github.com/puppetlabs/puppetserver-helm-chart/issues/9)

**Merged pull requests:**

- Bump Chart Ver. Update CHANGELOG. [\#17](https://github.com/puppetlabs/puppetserver-helm-chart/pull/17) ([Xtigyro](https://github.com/Xtigyro))
- Chart v1.5.1 [\#16](https://github.com/puppetlabs/puppetserver-helm-chart/pull/16) ([Xtigyro](https://github.com/Xtigyro))

## [v1.5.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.5.0) (2019-12-01)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.4.0...v1.5.0)

**Implemented enhancements:**

- rollup commit from sean.conley [\#13](https://github.com/puppetlabs/puppetserver-helm-chart/pull/13) ([slconley](https://github.com/slconley))

**Merged pull requests:**

- Update README.md [\#15](https://github.com/puppetlabs/puppetserver-helm-chart/pull/15) ([Xtigyro](https://github.com/Xtigyro))
- Chart v1.5.0 [\#14](https://github.com/puppetlabs/puppetserver-helm-chart/pull/14) ([Xtigyro](https://github.com/Xtigyro))

## [v1.4.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.4.0) (2019-11-30)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.3.1...v1.4.0)

**Merged pull requests:**

- Use default path for eYaml keys [\#12](https://github.com/puppetlabs/puppetserver-helm-chart/pull/12) ([Xtigyro](https://github.com/Xtigyro))
- Chart v1.4.0 [\#11](https://github.com/puppetlabs/puppetserver-helm-chart/pull/11) ([Xtigyro](https://github.com/Xtigyro))
- \(maint\) Update for cert documentation [\#8](https://github.com/puppetlabs/puppetserver-helm-chart/pull/8) ([underscorgan](https://github.com/underscorgan))

## [v1.3.1](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.3.1) (2019-11-24)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.3.0...v1.3.1)

## [v1.3.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.3.0) (2019-11-23)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.2.2...v1.3.0)

**Merged pull requests:**

- Chart - v1.3.0 [\#6](https://github.com/puppetlabs/puppetserver-helm-chart/pull/6) ([Xtigyro](https://github.com/Xtigyro))

## [v1.2.2](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.2.2) (2019-11-21)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.2.1...v1.2.2)

**Merged pull requests:**

- Chart v1.2.2 [\#5](https://github.com/puppetlabs/puppetserver-helm-chart/pull/5) ([Xtigyro](https://github.com/Xtigyro))

## [v1.2.1](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.2.1) (2019-11-17)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.2.0...v1.2.1)

**Merged pull requests:**

- Fixes for "r10k" Extra Container Args. [\#4](https://github.com/puppetlabs/puppetserver-helm-chart/pull/4) ([Xtigyro](https://github.com/Xtigyro))

## [v1.2.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.2.0) (2019-11-16)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.1.0...v1.2.0)

**Merged pull requests:**

- Chart v1.2.0 [\#3](https://github.com/puppetlabs/puppetserver-helm-chart/pull/3) ([Xtigyro](https://github.com/Xtigyro))

## [v1.1.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.1.0) (2019-11-15)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.0.1...v1.1.0)

**Merged pull requests:**

- V110 [\#2](https://github.com/puppetlabs/puppetserver-helm-chart/pull/2) ([Xtigyro](https://github.com/Xtigyro))

## [v1.0.1](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.0.1) (2019-11-07)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v1.0.0...v1.0.1)

## [v1.0.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v1.0.0) (2019-11-06)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v0.3.5...v1.0.0)

**Merged pull requests:**

- Add pvc nodeselector [\#1](https://github.com/puppetlabs/puppetserver-helm-chart/pull/1) ([Xtigyro](https://github.com/Xtigyro))

## [v0.3.5](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v0.3.5) (2019-10-30)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v0.3.4...v0.3.5)

## [v0.3.4](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v0.3.4) (2019-10-27)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v0.3.3...v0.3.4)

## [v0.3.3](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v0.3.3) (2019-10-26)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v0.3.2...v0.3.3)

## [v0.3.2](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v0.3.2) (2019-10-26)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v0.3.1...v0.3.2)

## [v0.3.1](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v0.3.1) (2019-10-24)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v0.2.4...v0.3.1)

## [v0.2.4](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v0.2.4) (2019-10-12)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v0.2.3...v0.2.4)

## [v0.2.3](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v0.2.3) (2019-10-11)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v0.2.2...v0.2.3)

## [v0.2.2](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v0.2.2) (2019-10-09)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/v0.2.0...v0.2.2)

## [v0.2.0](https://github.com/puppetlabs/puppetserver-helm-chart/tree/v0.2.0) (2019-09-20)

[Full Changelog](https://github.com/puppetlabs/puppetserver-helm-chart/compare/237af8eaff7490fe50986c07251e1494789f8282...v0.2.0)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
