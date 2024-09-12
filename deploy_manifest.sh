#!/bin/bash

##############################################################################
#            Applying the Manifest Files in a Correct Order
##############################################################################

# Directory where the manifest files are stored
MANIFEST_DIR="./"

# Function to apply a manifest file with echo output
apply_manifest() {
    echo "Applying $1..."
    kubectl apply -f "$MANIFEST_DIR/$1"
    echo "------------------------------------------------------------"
}

# Apply CRDs first
echo "---------------------------------------------"
echo "Apply the Custom Resource Definitions (CRDs):"
echo "---------------------------------------------"
apply_manifest "pan-cn-mgmt-slot-crd.yaml"
apply_manifest "pan-cn-ngfw-port-crd.yaml"
echo "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"

# Apply Persistent Volumes
echo "-----------------------------"
echo "Apply the Persistent Volumes:"
echo "-----------------------------"
apply_manifest "pan-cn-pv-local.yaml"
echo "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"

# Apply ConfigMaps and Secrets
echo "---------------------------------"
echo "Apply the ConfigMaps and Secrets:"
echo "---------------------------------"
apply_manifest "pan-cn-ngfw-configmap.yaml"
apply_manifest "pan-cn-mgmt-configmap.yaml"
apply_manifest "pan-cni-configmap.yaml"
apply_manifest "pan-cn-mgmt-secret.yaml"
echo "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"

# Apply StatefulSet and Deployments
echo "--------------------------------------"
echo "Apply the StatefulSet and Deployments:"
echo "--------------------------------------"
apply_manifest "pan-cn-mgmt.yaml"
apply_manifest "pan-cn-ngfw.yaml"
echo "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"

# Apply the CNI DaemonSet
echo "------------------------"
echo "Apply the CNI DaemonSet:"
echo "------------------------"
apply_manifest "pan-cni.yaml"
echo "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"

# Apply Services and Custom Resources
echo "----------------------------------------"
echo "Apply the Services and Custom Resources:"
echo "----------------------------------------"
apply_manifest "pan-cn-ngfw-svc.yaml"
apply_manifest "pan-cn-mgmt-slot-cr.yaml"
apply_manifest "pan-cn-ngfw-port-cr.yaml"
echo "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"

echo "All manifest files applied successfully!"
