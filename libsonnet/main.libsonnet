<<<<<<< HEAD
local input = std.extVar("kct.io/input");
local package = std.extVar("kct.io/package");
local release = std.extVar("kct.io/release");
local files = std.extVar("kct.io/files");
local include = std.extVar("kct.io/include");
||||||| parent of 288976a (Basic structure for a CLI in Golang)
local inputs = std.extVar("kct.io/input");
local package = std.extVar("kct.io/package");
local release = std.extVar("kct.io/release");
local files = std.extVar("kct.io/files");
local include = std.extVar("kct.io/include");
=======
local inputs = std.extVar("kateto.io/input");
local package = std.extVar("kateto.io/package");
local release = std.extVar("kateto.io/release");
local files = std.extVar("kateto.io/files");
local include = std.extVar("kateto.io/include");
>>>>>>> 288976a (Basic structure for a CLI in Golang)

{
	name: if release != null then '%s-%s' % [release.name, package.name] else package.name,
	input: input,
	package: package,
	release: release,
	files(glob, input = input): files(glob, input),
	include(dep, input = null): include(dep, input),
	sdk: import 'sdk.libsonnet',
}
