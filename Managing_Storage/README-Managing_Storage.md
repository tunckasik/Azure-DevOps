# Assignment 6 - Managing Azure Storage

I am assigned to evaluate the use of Azure storage for storing files residing currently in on-premises data stores.
I am wanted to minimize cost of storage by placing less frequently accessed files in lower-priced storage tiers as cool access tier.
I am also requested to explore different protection mechanisms that Azure Storage offers, including network access, authentication, authorization, and replication.
Finally, I am directed to determine to what extent Azure Files service might be suitable for hosting our on-premises file shares.

## Objectives

For this assignment there are 6 steps;

+ Step 1: Provisioning the assignment environment
+ Step 2: Creating and configuring Azure Storage accounts
+ Step 3: Managing blob storage
+ Step 4: Managing authentication and authorization for Azure Storage
+ Step 5: Creating and configuring an Azure Files shares
+ Step 6: Managing network access for Azure Storage

#### Step 1: Provisioning the assignment environment

In this step, I deployed an Azure virtual machine that I will use later while creating and configuring an Azure Files shares. I upload the JSON files **A6-vm-template.json** and **A6-vm-parameters.json** into the Cloud Shell home directory. From the Cloud Shell pane, running the following to deploy the virtual machine by using the uploaded template and parameter files:

   ```powershell
   $rgName = 'eastus'
   ```

   ```powershell
   New-AzResourceGroupDeployment `
      -ResourceGroupName $rgName `
      -TemplateFile $HOME/A6-vm-template.json `
      -TemplateParameterFile $HOME/A6-vm-parameters.json `
      -AsJob
   ```

#### Step 2: Creating and configuring Azure Storage accounts

In this step, I create and configure an Azure Storage account. While creating the storage account I kept same default option **Enable public access from all networks** for the networking. As configuring the storage account I changed the redundancy to **LRS** and set **Blob access tier (default)** to **Cool**. Because the cool access tier is optimal for data which is not accessed frequently.

#### Step 3: Managing blob storage

In this step, I create a blob container and upload a blob into it. I selected **Block blob** type with **Hot** Access tier under **Licenses** folder.

#### Step 4: Managing authentication and authorization for Azure Storage

In this step, I configure authentication and authorization for Azure Storage.

At the begining I want to check whether the provisioned blob file is accessable from internet or not. I am presented with an XML-formatted message stating **ResourceNotFound** or **PublicAccessNotPermitted**. This is expected, since the container I created has the public access level set to **Private (no anonymous access)**.

After generating a **SAS** I have a **Blob SAS URL** to access the blob file. As expected, I can access the blob file, since my access is authorized based on the newly generated the SAS token.

For the authentication configuration; while switching to the **Azure AD User Account**, I see an error when I change the authentication method (the error is *"You do not have permissions to list the data using your user account with Azure AD"*) as expected. That means I don't have permissions to change the Authentication method.
To change and obtain the **Storage Blob Data Owner** role, I navigate to **Access Control (IAM)** and add the role to the members as the name of my user account.AFter that I verify that I change the Authentication method to (Switch to Azure AD User Account).

#### Step 5: Creating and configuring an Azure Files shares

In this step, I create and configure Azure Files shares. I start with creating a file share and connect to it. My target is connecting to the storage account from the VM which I created at the beginning of this assignment. I selected the **Windows** as my VM's OS is Windows. I copied the **Script** into the VM by using run command. Then after that I replace the content as below;
1. **PowerShell Script** pane with the following script:

   ```powershell
   New-Item -Type Directory -Path 'Z:\A6-folder'

   New-Item -Type File -Path 'Z:\A6-folder\A6-file.txt'
   ```
> **Note**:That **Script** I copied was from file share.

1. After navigating back to the file share, I verify that **A6-file.txt** appears under **A6-folder** in the list of folders.

#### Step 6: Managing network access for Azure Storage

In this step, I configure network access for Azure Storage. In the Azure portal, navigating back to the blade of the storage account I created in the first Step of this assignment and, then clicking **Firewalls and virtual networks** under Networking. Enabling "Enabled from selected virtual networks and IP addresses" option. I use these settings to configure direct connectivity between Azure virtual machines on designated subnets of virtual networks and the storage account by using service endpoints.I select **Add your client IP address** and verify the blob SAS URL I generated in the previous step. I am presented with the content of **The MIT License (MIT)** page as expected. Since I am connecting from my client IP address.
But on Azure Cloud Shell pane, while I am running the following to attempt downloading of the LICENSE blob from the **A6-container** container of the storage account:

   ```powershell
   Invoke-WebRequest -URI '[generated blob SAS URL]'
   ```
I verify that the download attempt failed. I receive the message stating **AuthorizationFailure: This request is not authorized to perform this operation**. This is expected, since I am connecting from the IP address assigned to an Azure VM hosting the Cloud Shell instance.

#### Review

In this assignment, I have:

- Provisioned the assignment environment
- Created and configured Azure Storage accounts
- Managed blob storage
- Managed authentication and authorization for Azure Storage
- Created and configured an Azure Files shares
- Managed network access for Azure Storage

Thank you for your time!