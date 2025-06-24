local inputs = std.extVar("kateto.io/input");
local package = std.extVar("kateto.io/package");
local release = std.extVar("kateto.io/release");
local files = std.extVar("kateto.io/files");
local include = std.extVar("kateto.io/include");

{
	name: if release != null then '%s-%s' % [release.name, package.name] else package.name,
	input: inputs,
	package: package,
	release: release,
	files(glob, input = inputs): files(glob, input),
	include(dep, input = null): include(dep, input),
	sdk: import 'sdk.libsonnet',
}
