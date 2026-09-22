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

read -rsp "Senha do administrador do Azure SQL: " SQL_PASSWORD
echo

az keyvault create --resource-group $RG_NAME --name $KEYVAULT --location $LOCATION --sku standard --enable-rbac-authorization true --public-network-access Enabled

KEYVAULT_ID=$(az keyvault show --resource-group $RG_NAME --name $KEYVAULT --query id --output tsv)

CURRENT_USER_ID=$(az ad signed-in-user show --query id --output tsv)
 
az role assignment create --assignee-object-id $CURRENT_USER_ID --assignee-pricipal-type User --role "?" --scope $KEYVAULT_ID

az keyvault secret set --vault-name $KEYVAULT --name "sql-password" --value $SQL_PASSWORD

WEBAPP_PRINCIPAL_ID=$(az webapp identity assign --resource-group $RG_NAME --name $WEBAPP_NAME --query principalId --output tsv)

# permitir a aplicação let os segredos
az role assignment create --assignee-object-id $WEBAPP_PRINCIPAL_ID --assignee-principal-type ServicePrincipal --role "?" --scope $KEYVAULT_ID

