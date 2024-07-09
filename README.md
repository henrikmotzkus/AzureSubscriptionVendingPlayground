# Azure Subscription Vending Playground

This tutorial is about building a terraform module that can create subscriptions in Azure  configure them and create specific bootstrap resources. i. e. creating a budget. My approach is to modularize it as much as possible. And use this module in script mode not TF state mode. I don't want to maintain a TF state.

preqreqs: An azure ea agreement and a management group and a user with permissions to create subscritpion. i. e. Account admin of an Enrollment account.

# Step 1

This step is about creating a plain subscription containing no resources. This subscription is creasted out of an enterprise agreement. This module deploys some tags on the subscription and moves it into a existing management group.

For this we need some variables

1. a billing scope
2. some tags
3. a workload type
4. and a management group name

Additinally we want to generate the display name of the subscription automatically.

After deploying it the module shoud output the subscription id.

todos

1. Download terraform
2. Download az cli
3. Login with az login
4. Change to directory step_1
5. terrform init
6. terraform plan (mit parameter file)
7. terraform apply



# Step 2

This step creates a main TF file that will call the code from step 1 as a module. With sthis step we modularize our code out of step 1. The module need to be fully parameterized.

# Step 3

This step creates an additional module that is used to create some resources in the newly created fresh subscription. Please keep in mind that deploying a subscription and subsequent resources can't be accomplished in the same step. We need a relogin after step 1 in order to get access to the new subscription.This is unfortunytely a limitation of the TF azurerm module.

# Step 4

Now we have learned the principles of TF and Azure and can use the standard modules of Microsoft. This means we want to deploy more subscriptions and deploy more sophisticated scenarios. The intent of this module is to show what is possible. And it overcomes that limitation of step 3. This module can create subscription and resources in one deployment because it uses the azurerm TF module and the azapi module. 