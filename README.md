# Creative Studio Application Module

This is a [Timoni](https://timoni.sh) CUE module for the Creative Studio application. It defines the base deployment configurations, service ports, and network policies, replacing the previous Kustomize structure.

## Structure

- **templates/**: Contains the CUE definitions for Kubernetes resources (Deployment, Service, NetworkPolicies).
- **values.cue**: Contains the default values representing the application base configuration.
- **../values-dev.cue**: External file containing values overrides for the development environment.

## Requirements
- `timoni` CLI
- A running Kubernetes cluster

## Building Manifests (Local Validation)

To output the raw YAML manifests without applying them to the cluster:

**1. Base Configuration**
Run this from inside the `myapp` directory:
```sh
timoni build myapp . -n creative-studio
```

**2. Dev Overlay Configuration**
Run this from inside the `myapp` directory (notice the `-f` pointing to the external values file):
```sh
timoni build myapp-dev . -f ..\values-dev.cue -n creative-studio
```

## Applying to the Cluster

To install or upgrade the application directly to your Kubernetes cluster:

**1. Base Overlay (Default)**
```sh
timoni apply myapp . -n creative-studio
```

**2. Dev Overlay**
```sh
timoni apply myapp-dev . -f ..\values-dev.cue -n creative-studio
```

## Exploring Values
You can inspect the configuration schema:
```sh
timoni mod vet .
```
