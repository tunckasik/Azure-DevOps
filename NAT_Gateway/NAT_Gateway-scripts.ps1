# To deploy the template to create a vm and vnet with NAT gateway
New-AzResourceGroupDeployment `
  -Name rgNAT `
  -ResourceGroupName rgNAT `
  -TemplateUri https://raw.githubusercontent.com/tunckasik/Nxa1!!.json `
  -storageAccountType Standard_GRS

$resourceGroupName = Read-Host -Prompt "Enter the Resource Group name"
$location = Read-Host -Prompt "Enter the location (i.e. eastus)"
$templateUri = ""
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri $templateUri -Location $location