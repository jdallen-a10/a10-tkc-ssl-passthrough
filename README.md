# a10-tkc-ssl-passthrough
Setup a Thunder node to passthrough SSL packets to a Cloud Application running on Kubernetes and using the A10 Thunder Kubernetes Connector (TKC) to configure the Thunder node.

This demo configures three webservers with SSL certs (you will have to provide your own cert and key file), and sets up TKC to just pass the SSL packets through to the Application Pods running in Kubernetes.

Notice there there is an "ID.tf" file that I use to mark my Kubernetes main node with which demo I am running. This most likely will not be needed in your environment, so feel free to delete it.

