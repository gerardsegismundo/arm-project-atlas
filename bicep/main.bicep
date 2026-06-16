@description('Number of resources to create in the loop')
param vmCount int = 3

@description('Create storage account?')
param createStorage bool = true

// Virtual Network
resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: 'myVnet'
  location: resourceGroup().location

  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
}

resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' = if (createStorage) {
  name: 'stg${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location

  sku: {
    name: 'Standard_LRS'
  }

  kind: 'StorageV2'

  dependsOn: [
    vnet
  ]
}

resource demoResources 'Microsoft.Compute/availabilitySets@2023-09-01' = [
  for i in range(0, vmCount): {
    name: 'vmset-${i}'
    location: resourceGroup().location

    dependsOn: [
      vnet
    ]
  }
]
