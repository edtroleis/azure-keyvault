# Azure Key Vault
Create a key vault with 3 secrets according to cosmosdb keys and connection strings

<br>

# Set variables to test locally
```
export accountName="cosmosdttest"
export resourceGroupName="keyvault"
export region="EastUS"
export keyvaultName="keyvaulttest"
export username="test@outlook.com"
```

# List resource groups
```
az group list --output table
```

# List cosmosdb keys
```
az cosmosdb keys list --name $accountName --resource-group $resourceGroupName
```