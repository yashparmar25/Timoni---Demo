package templates

import (
	networkingv1 "k8s.io/api/networking/v1"
)

#NetworkPolicyDenyAll: networkingv1.#NetworkPolicy & {
	#config:    #Config
	apiVersion: "networking.k8s.io/v1"
	kind:       "NetworkPolicy"
	metadata: {
		name:      "\(#config.metadata.name)-deny-all"
		namespace: #config.metadata.namespace
		labels:    #config.metadata.labels
		if #config.metadata.annotations != _|_ {
			annotations: #config.metadata.annotations
		}
	}
	spec: networkingv1.#NetworkPolicySpec & {
		podSelector: matchLabels: #config.selector.labels
		policyTypes: ["Ingress", "Egress"]
	}
}

#NetworkPolicyAllowIngress: networkingv1.#NetworkPolicy & {
	#config:    #Config
	apiVersion: "networking.k8s.io/v1"
	kind:       "NetworkPolicy"
	metadata: {
		name:      "\(#config.metadata.name)-allow-ingress"
		namespace: #config.metadata.namespace
		labels:    #config.metadata.labels
		if #config.metadata.annotations != _|_ {
			annotations: #config.metadata.annotations
		}
	}
	spec: networkingv1.#NetworkPolicySpec & {
		podSelector: matchLabels: #config.selector.labels
		policyTypes: ["Ingress"]
		ingress: [
			{
				from: [
					{
						ipBlock: cidr: "0.0.0.0/0"
					},
				]
				ports: [
					{
						protocol: "TCP"
						port:     #config.service.targetPort
					},
				]
			},
		]
	}
}

#NetworkPolicyAllowEgress: networkingv1.#NetworkPolicy & {
	#config:    #Config
	apiVersion: "networking.k8s.io/v1"
	kind:       "NetworkPolicy"
	metadata: {
		name:      "\(#config.metadata.name)-allow-egress"
		namespace: #config.metadata.namespace
		labels:    #config.metadata.labels
		if #config.metadata.annotations != _|_ {
			annotations: #config.metadata.annotations
		}
	}
	spec: networkingv1.#NetworkPolicySpec & {
		podSelector: matchLabels: #config.selector.labels
		policyTypes: ["Egress"]
		egress: [
			{
				to: [
					{
						ipBlock: cidr: "0.0.0.0/0"
					},
				]
			},
		]
	}
}
