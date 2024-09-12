#!/bin/bash

# Directory where the manifest files are stored
MANIFEST_DIR="./"

# Apply CRDs first
echo "Applying Custom Resource Definitions (CRDs)..."
kubectl apply -f "$MANIFEST_DIR/pan-cn-mgmt-slot-crd.yaml"
kubectl apply -f "$MANIFEST_DIR/pan-cn-ngfw-port-crd.yaml"

# Apply ConfigMaps
echo "Applying ConfigMaps..."
kubectl apply -f "$MANIFEST_DIR/pan-cn-mgmt-configmap.yaml"
kubectl apply -f "$MANIFEST_DIR/pan-cn-ngfw-configmap.yaml"
kubectl apply -f "$MANIFEST_DIR/pan-cni-configmap.yaml"

# Apply Secrets
echo "Applying Secrets..."
kubectl apply -f "$MANIFEST_DIR/pan-cn-mgmt-secret.yaml"

# Apply Persistent Volumes
echo "Applying Persistent Volumes..."
kubectl apply -f "$MANIFEST_DIR/pan-cn-pv-local.yaml"

# Apply Management Components
echo "Applying Management Components..."
kubectl apply -f "$MANIFEST_DIR/pan-cn-mgmt.yaml"

# Apply NGFW Components
echo "Applying NGFW Components..."
kubectl apply -f "$MANIFEST_DIR/pan-cn-ngfw.yaml"

# Apply Slot and Port Configuration (Custom Resources)
echo "Applying Slot and Port Custom Resources..."
kubectl apply -f "$MANIFEST_DIR/pan-cn-mgmt-slot-cr.yaml"
kubectl apply -f "$MANIFEST_DIR/pan-cn-ngfw-port-cr.yaml"

# Apply CNI Plugin
echo "Applying CNI Plugin..."
kubectl apply -f "$MANIFEST_DIR/pan-cni.yaml"

# Apply Service to expose NGFW
echo "Applying Service..."
kubectl apply -f "$MANIFEST_DIR/pan-cn-ngfw-svc.yaml"