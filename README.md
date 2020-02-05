# azure-vault-consul-packer
1. [Download packer](https://packer.io/downloads.html)

2. Set these env vars are set in your local system
 - ARM_SUBSCRIPTION_ID
 - ARM_TENANT_ID
 - ARM_CLIENT_ID
 - ARM_CLIENT_SECRET
 - AZURE_ACCOUNT_NAME
 - AZURE_ACCOUNT_KEY
 - AZURE_CONTAINER

3. ```az group create --location "West US 2" --name vault-ent```
4. ```az storage account create --location "West US 2"  --name vaultentsa  --resource-group cdvault-ent --sku Standard_LRS```

5. GET KEYS AFTER YOU CREATE:
  * ```az storage account keys list  --account-name vaultentsa --resource-group cdvault-ent --output table```

6. create storage container
  * ```az storage container create -n MyStorageContainer --account-key $AZURE_ACCOUNT_KEY --account-name $AZURE_ACCOUNT_NAME```

7. Change the resource_group_name to match the name you created in step 1
 * ```"resource_group_name": "vault-ent",```

8. Build packer image 
 * ```packer build vault-enterprise-consul.json```

9. [Build a VMSS in azure](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Compute%2FvirtualMachineScaleSets)
  * Add the custom-data.sh to the Cloud-Init portion of the Azure MVSS build
    - Update the environment variables to your values 