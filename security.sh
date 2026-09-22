#!/bin/bash
 
RM=566299
LOCATION=chilecentral
RG_NAME=rg-webapp-sql
SQL_SERVER="sql-dimdim-$RM"
SQL_DATABASE=db-dimdim
SQL_ADMIN=user-dimdim
PLAN_NAME=plan-dimdim
WEBAPP_NAME="webapp-sql-dimdim-$RM"
KEYVAULT="kv-webapp-sql-$RM"

az keyvault create --resource-group $RG_NAME --name $KEYVAULT --location $LOCATION --sku standard --enable-rbac-authorization true --public-network-access Enabled

KEYVAULT_ID=$(az keyvault show --resource-group $RG_NAME --name $KEYVAULT --query id --output tsv)

CURRENT_USER_ID=$(az ad signed-in-user show --query id --output tsv)
 
az role assigment create --assignee-object-id $CURRENT_USER_ID --assignee-pricipal-type User --role "?" --scope $KEYVAULT_ID

