# Kubernetes Configuration Tool


> [!WARNING]
> The Rust version of this project is no longer under development. The project will undergo a transition to Golang, since most of Jsonnet tooling is native to that, and be renamed to Kateto.
> 
> The initial design won't change much, but it'll become only a templating tool instead of a complete replacement for Tanka and Helm. Instead of doing everything, we'll aim for it to be easy to integrate into GitOps tools such as ArgoCD.
> 
> If you want to take a look at what's coming up, head over to the [`next` branch](https://github.com/bruno-delfino1995/kateto/tree/next) and help us there 🙌

[![build](https://img.shields.io/github/actions/workflow/status/bruno-delfino1995/kct/quality.yml?branch=main)](https://github.com/bruno-delfino1995/kct/actions/workflows/lints.yml?query=branch%3Amain)
[![license](https://img.shields.io/github/license/bruno-delfino1995/kct)](https://github.com/bruno-delfino1995/kct/blob/main/LICENSE)
[![version](https://img.shields.io/github/v/release/bruno-delfino1995/kct?label=version)](https://github.com/bruno-delfino1995/kct/releases/latest)
[![coverage](https://codecov.io/gh/bruno-delfino1995/kct/branch/main/graph/badge.svg?token=VAXMGX6OKU)](https://codecov.io/gh/bruno-delfino1995/kct)
[![dependency status](https://deps.rs/repo/github/bruno-delfino1995/kct/status.svg)](https://deps.rs/repo/github/bruno-delfino1995/kct)

KCT is a tool for taming the Kubernetes configuration beast by using Jsonnet while borrowing approaches and concepts from early contestants such as Tanka and Helm.

> [!NOTE]
> Despite our `0.x.y` releases being "production ready", don't expect API stability before a 1.0 release as [anything may change](https://semver.org/#spec-item-4) due to experimentation and feedback.

## Installation

### Releases

You can take a look at our [Releases Page](https://github.com/bruno-delfino1995/kct/releases); we build binaries for most platforms. From there, grab the binary that matches your platform and add it to your `$PATH`

### Build from sources

Our minimum supported Rust version (MSRV) is the latest stable version, and it'll likely remain that way until we consider external extensions. To build it from source, you just need to run:

``` sh
cargo build --bin=kct --release
```

And if you have the cargo bin folder on your path, you can install it directly with:

``` sh
cargo install --path=bin
```

## Documentation

If you would like more information about the tool's components and inner workings, please refer to the [documentation](./docs/index.md). There you'll find a description of the [package](./docs/kcp.md) structure and feature, along with the [commands](./docs/usage.md) with brief explanations about their tasks.

## Contributing

Any contribution is welcome, whether it is an issue or a PR. I'm very new to Rust, so anything in the code that seems wrong, feel free to point it out.

## LICENSE

MIT © Bruno Delfino
