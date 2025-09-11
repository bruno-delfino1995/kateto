# Kubernetes Configuration Package (KCP)

The package structure defined by Kateto to build your K8s objects.

<a name="structure"></a>

## Structure

A KCP is any directory or `.tgz` file that inside has the following structure:

```text
kcp[.tgz]/
├── kcp.json            # manifest file
├── templates/          # directory for your Jsonnet templates
│   └── main.jsonnet    # compilation entrypoint
├── example.json        # OPTIONAL: example inputs
├── schema.json         # OPTIONAL: schema to validate your inputs
├── lib/                # OPTIONAL: aliases or internal libs
├── vendor/             # OPTIONAL: external libs and subpackages managed by Jsonnet Bundler
└── files/              # OPTIONAL: files to be compiled by Tera
```

The minimal structure consists of the manifest file (`kcp.json`) and the compilation entrypoint (`templates/main.jsonnet`). For inputs we have `schema.json` and `example.json` as mutual dependents. For libraries, there're `vendor` and `lib` mirroring the concepts from [Tanka](https://tanka.dev/libraries/import-paths). For general files, a name borrowed from [Helm](https://helm.sh/docs/chart_template_guide/accessing_files/#helm), that you might want to include, there's the `files` directory; however, differently from Helm, these are rendered by [Tera](https://tera.netlify.app/docs). And finally, there's the `kcps` directory which contains the packages declared in your manifest as dependencies

To have a better grasp of the structure and features, take a look at the [example package][example-kcp] that we use for testing

<a name="manifest"></a>

## Manifest Format

As we're talking about Jsonnet and not Yamlnet, I've decided to use a simple JSON file with the following properties:

```json
{
	"name": "kcp",
	"version": "1.0.0"
}
```

In this example, we've declared a package named `kcp` at version `1.0.0`. which depends upon `prometheus` on `1.1.0` stored at `http://repo.com/packages/prometheus` under tag `1.1.0`. For Jsonnet dependecies we use the Jsonnet Bundler, just declare it in your `jsonnetfile.json`. We've chosen to rely on Jsonnet Bundler at the beginning due to being a fairly used project and to validate our idea before having to implement a whole dependency system from scratch.

<a name="built-in"></a>

## Built-in Objects

To aid developers with external info and utilities, we inject the `_` global into your templates. Within this global each property fulfills a specific purpose. The global structure consists of:

- `name`: the "installation" name, it's your package name with the release name - use this as your prefix in the templates
- `input`: injected input that are the result of merging your inputs provided during compilation
- `files`: function that receives a blob and will return a list with the contents of rendered files
- `include`: function that receives a package name and an object for input and will return the rendered subpackage
- `package`: information about your package that can help you scope your resources
	- `name`: from the manifest file
  - `version`: from the manifest file
- `release`: information about the release being manipulated
	- `name`: the name provided when compiling

<a name="objects"></a>

## Objects

The sole goal of a KCP is to render the necessary [resources][k8s-objects] into K8s. These resources are defined by the KCP developer and found by the tool walking down the object properties until it finds the [required fields][k8s-required-fields] of an object (note that we don't check for `spec` once [secrets don't use it][k8s-secret]). For instance, the following template would render a set of objects:

```jsonnet
{
  // Grafana
  grafana: {
    deployment: {
      apiVersion: 'apps/v1',
      kind: 'Deployment',
      metadata: {
        name: 'grafana',
      }, // ...
    },
    service: {
      apiVersion: 'v1',
      kind: 'Service',
      metadata: {
        name: 'grafana',
      }, // ...
    },
  },

  // Prometheus
  prometheus: {
    deployment: {
      apiVersion: 'apps/v1',
      kind: 'Deployment',
      metadata: {
        name: 'prometheus',
      }, // ...
    },
    service: {
      apiVersion: 'v1',
      kind: 'Service',
      metadata: {
        name: 'prometheus',
      }, // ...
    },
  },
}
```

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana
# ...
---
apiVersion: apps/v1
kind: Service
metadata:
  name: grafana
# ...
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: prometheus
# ...
---
apiVersion: apps/v1
kind: Service
metadata:
  name: prometheus
# ...
```

<a name="objects--extensibility"></a>

### Extensibility

By leveraging Jsonnet as our data template engine, we get operators such as the [object composition][jsonnet-oo] that allow a developer to override configs defined in other packages. With this operator at hand and subpackages, we enable patterns such as:

```jsonnet
_.include('grafana') + {
	deployment+: {
		spec+: {
			replicas: 2
		}
	}
}
```

Which results in the override of a specific property without duplicating everything. That also highlights that your rendered structure is the API for your package, and since arrays are harder to extend, **we don't allow arrays in the API**. With this constraint, the pattern below is disallowed:

```jsonnet
{
	deployments: [
		{ metadata: { name: "grafana" } },
		{ metadata: { name: "prometheus" } },
	],
	services: [
		{ metadata: { name: "grafana" } },
		{ metadata: { name: "prometheus" } },
	]
}
```

Where the "deliverables" get hidden behind K8s concepts, difficulting extension and blurrying the components of the package. Although, note that if a package only has one component that consists of a deployment and a service, don't bother finding terms to abstract K8s, we're managing K8s anyway.

[jsonnet-oo]: https://jsonnet.org/learning/tutorial.html#oo
[k8s-objects]: https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/
[k8s-required-fields]: https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/#required-fields
[k8s-secret]: https://kubernetes.io/docs/concepts/configuration/secret/
[example-kcp]: https://github.com/kseat/kateto/tree/master/samples/plain
