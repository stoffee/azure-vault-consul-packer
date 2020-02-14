# azure-vault-consul-packer
1. [Download packer](https://packer.io/downloads.html)

2. [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

3. Set these env vars are set in your local system
 - ARM_SUBSCRIPTION_ID
 - ARM_TENANT_ID
 - ARM_CLIENT_ID
 - ARM_CLIENT_SECRET

4. ```az login && az group create --location "West US 2" --name vault-img```
5. ```az storage account create --location "West US 2"  --name vaultentsa  --resource-group vault-img --sku Standard_LRS```

6. GET KEYS AFTER YOU CREATE:
  * ```az storage account keys list  --account-name vaultentsa --resource-group vault-img --output table```

7. create storage container
  * ```az storage container create -n VaultEntContainer --account-key $AZURE_ACCOUNT_KEY --account-name $AZURE_ACCOUNT_NAME```

8. Set these env vars
 - AZURE_ACCOUNT_NAME
 - AZURE_ACCOUNT_KEY
 - AZURE_CONTAINER

9. Edit vault-enterprise-consul.json and change the resource_group_name to match the name you created in step 4
 * ```"resource_group_name": "vault-img",```

10. Add your Certificats to the tls directory and update cert names in vault-enterprise-consul.json
  * crt.pem, key.pem, and full_chain.pem
  * ```"ca_public_key_path": "./tls/ca.crt.pem",```
  * ```"tls_public_key_path": "./tls/vault.crt.pem",```
  * ```"tls_private_key_path": "./tls/vault.key.pem"```

11. Build packer image 
 * ```packer build vault-enterprise-consul.json```

12. [Build a VMSS in azure](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Compute%2FvirtualMachineScaleSets)
  * Add the custom-data.sh to the Cloud-Init portion of the Azure MVSS build
    - Update the environment variables to your values 

13. Alternative step to 12 is to use the create-vmss.sh on the cli.