local _ = import 'kateto.libsonnet';

local errors = {
	'variable': import './errors/variable.jsonnet',
	'include': import './errors/include.jsonnet',
};

errors[_.input.type]
