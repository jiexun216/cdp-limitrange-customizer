
# Kubernetes Admission Webhook cdp-limitrange-customizer

This tutoral shows how to build and deploy an [AdmissionWebhook](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/#admission-webhooks). which designed to modify StatefulSet or Deployment or Job quota-limitrange.

The mutating webhook in the cdp-limitrange-customizer adds a specific annotation with `mutated` set as the value.

## Prerequisites

Kubernetes 1.9.0 or above with the `admissionregistration.k8s.io/v1beta1` API enabled. Verify that by the following command:
```
kubectl api-versions | grep admissionregistration.k8s.io/v1beta1
```
The result should be:
```
admissionregistration.k8s.io/v1beta1
```

In addition, the `MutatingAdmissionWebhook` and `ValidatingAdmissionWebhook` admission controllers should be added and listed in the correct order in the admission-control flag of kube-apiserver.

## Quickstart

Step One, Build and push docker image, run this in the root directory.

    $ ./build


Step Two, produce webhook server https certificate, run this in the root directory.

    $ ./deployment/webhook-create-signed-cert.sh  --namespace jiexun-test


Step Three, create a specific serviceAccount for webhook deployment, run this in the root directory. or use the default serviceAccount, then skips it.
   
    $ kubectl  create -f  ./deployment/rbac.yaml 
    
    
Step Four, create service and deployment object, run this in the root directory.

    $ kubectl create -f deployment/service.yaml -n  jiexun-test
    $ kubectl create -f deployment/deployment.yaml -n jiexun-test

Step Five, config webhook MutatingWebhookConfiguration, run this in the root directory.

    $ cat ./deployment/mutatingwebhook.yaml | ./deployment/webhook-patch-ca-bundle.sh > ./deployment/mutatingwebhook-ca-bundle.yaml
    $ kubectl create -f deployment/mutatingwebhook-ca-bundle.yaml
    
    
At last, test the Admission webhooks server receive admission requests and modify object.
