# Project Atlas

## Features

- Creates 3 virtual machines using ARM copy loop
- Creates a storage account conditionally
- Demonstrates resource dependency with dependsOn

## Deployment

az deployment group create \
  --resource-group my-rg \
  --template-file template.json \
  --parameters parameters.json