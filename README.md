# azure-vault-consul-packer
1. [Download packer](https://packer.io/downloads.html)

2. [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

3. Set these env vars are set in your local system
 - ARM_SUBSCRIPTION_ID
 - ARM_TENANT_ID
 - ARM_CLIENT_ID
 - ARM_CLIENT_SECRET
 - AZURE_ACCOUNT_NAME
 - AZURE_ACCOUNT_KEY
 - AZURE_CONTAINER

4. ```az group create --location "West US 2" --name vault-ent```
5. ```az storage account create --location "West US 2"  --name vaultentsa  --resource-group vault-ent --sku Standard_LRS```

6. GET KEYS AFTER YOU CREATE:
  * ```az storage account keys list  --account-name vaultentsa --resource-group vault-ent --output table```

7. create storage container
  * ```az storage container create -n MyStorageContainer --account-key $AZURE_ACCOUNT_KEY --account-name $AZURE_ACCOUNT_NAME```

8. Change the resource_group_name to match the name you created in step 4
 * ```"resource_group_name": "vault-ent",```

9. Build packer image 
 * ```packer build vault-enterprise-consul.json```

10. [Build a VMSS in azure](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Compute%2FvirtualMachineScaleSets)
  * Add the custom-data.sh to the Cloud-Init portion of the Azure MVSS build
    - Update the environment variables to your values 