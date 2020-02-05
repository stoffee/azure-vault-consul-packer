#!/bin/bash
# This script is meant to be run in the Custom Data of each Azure Instance while it's booting. The script uses the
# run-consul script to configure and start Consul in server mode. Note that this script assumes it's running in an Azure Image
# built from the Packer template in examples/consul-ami/consul.json.

set -e

# Send the log output from this script to custom-data.log, syslog, and the console
exec > >(tee /var/log/custom-data.log|logger -t custom-data -s 2>/dev/console) 2>&1

source /etc/profile.d/arm.sh

# These variables are passed in via Terraform template interplation
/opt/consul/bin/run-consul --server --scale-set-name "$SCALE_SET_NAME" --subscription-id "$ARM_SUBSCRIPTION_ID" --tenant-id "$ARM_TENANT_ID" --client-id "$ARM_CLIENT_ID" --secret-access-key "$ARM_SECRET_ACCESS_KEY"

## vault's turn

# The Packer template puts the TLS certs in these file paths
readonly VAULT_TLS_CERT_FILE="/opt/vault/tls/vault.crt.pem"
readonly VAULT_TLS_KEY_FILE="/opt/vault/tls/vault.key.pem"

# The cluster_tag variables below are filled in via Terraform interpolation
/opt/vault/bin/run-vault --azure-account-name "$AZURE_ACCOUNT_NAME" --azure-account-key "$AZURE_ACCOUNT_KEY" --azure-container "$AZURE_CONTAINER" --tls-cert-file "$VAULT_TLS_CERT_FILE"  --tls-key-file "$VAULT_TLS_KEY_FILE"
