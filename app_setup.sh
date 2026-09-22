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

JDBC_URL="jdbc:sqlserver://{SQL_SERVER}.database.windows.net:1433;database=${SQL_DATABASE};encrypt???"
DATASOURCE_PASSWORD="@Microsoft.KeyVault(VaultName=${KEYVAULT};SecretName=sql-password)"

# Configurar variaveis de ambiente

az webapp config appsettings set --resource-group $RG_NAME --name $WEBAPP_NAME --settings "SPRING_DATASOURCE_URL=$JDBC_URL" "SPRING_DATASOURCE_USERNAME=$DATASOURCE_USERNAME" "SPRING_DATASOURCE_PASSWORD=$DATASOURCE_PASSWORD" --output none