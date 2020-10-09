#!/bin/bash

export accountName="cosmosdbtest"
export resourceGroupName="keyvault"
export region="EastUS"
export keyvaultName="keyvaulttest"
export username="test@outlook.com"

# Login
az login --username=$username

# Create resource group
az group create --name $resourceGroupName -l $region

# Create a key vault
az keyvault create --name $keyvaultName --resource-group $resourceGroupName --location $region

# Get Cosmos DB master account key
cosmosMasterKey="$(az cosmosdb list-keys \
        --name $accountName \
        --resource-group $resourceGroupName \
        --query "primaryMasterKey" \
        --output tsv)"

# Get Cosmos connection string
cosmosConnectionString=$(az cosmosdb keys list \
        -g $resourceGroupName \
        -n $accountName \
        --type connection-strings \
        --query connectionStrings[0].connectionString \
        --output tsv)

# insert keys into Azure Key Vault
az keyvault secret set --vault-name $keyvaultName --name "CosmosDBPassword" --value $cosmosMasterKey
az keyvault secret set --vault-name $keyvaultName --name "CosmosConnectionString" --value $cosmosConnectionString