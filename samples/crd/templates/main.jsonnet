local _ = import 'kateto.libsonnet';

{
	definition: {
		apiVersion: "apiextensions.k8s.io/v1",
		kind: "CustomResourceDefinition",
		metadata: {
			name: "crontabs.stable.example.com"
		},
		spec: {
			group: "stable.example.com",
			versions: [
				{
					name: "v1",
					served: true,
					storage: true,
					schema: {
						openAPIV3Schema: {
							type: "object",
							properties: {
								spec: {
									type: "object",
									properties: {
										cronSpec: {
											type: "string"
										},
										image: {
											type: "string"
										},
										replicas: {
											type: "integer"
										}
									}
								}
							}
						}
					}
				}
			],
			scope: "Namespaced",
			names: {
			plural: "crontabs",
				singular: "crontab",
				kind: "CronTab",
				shortNames: [
					"ct"
				]
			}
		}
	},
	object: {
		apiVersion: "stable.example.com/v1",
		kind: "CronTab",
		metadata: {
			name: "my-new-cron-object"
		},
		spec: {
			cronSpec: "* * * * */5",
			image: "my-awesome-cron-image"
		}
	}
}
