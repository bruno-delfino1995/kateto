local _ = import 'kateto.libsonnet';

{
	apiVersion: 'v1',
	kind: 'Secret',
	metadata: {
		name: _.name,
	},
	type: 'Opaque',
	data: {
		counter: std.toString(_.input.counter)
	}
}
