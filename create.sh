#!/bin/bash

# Declarar as variáveis
RM=566299
LOCATION=chilecentral
RG_NAME=rg-webapp-sql
SQL_SERVER="sql-dimdim-$RM"
SQL_DATABASE=db-dimdim
SQL_ADMIN=user-dimdim
PLAN_NAME=plan-dimdim
WEBAPP_NAME="webapp-sql-dimdim-$RM"

read -rsp "Senha do administrador do Azure SQL: " SQL_PASSWORD
echo

# Criar os recursos base
az group create --name $RG_NAME --location $LOCATION

# Criar o banco de dados
az sql server create --resource-group $RG_NAME --name $SQL_SERVER --location $LOCATION --admin-user $SQL_ADMIN --admin-password $SQL_PASSWORD

az sql db create --resource-group $RG_NAME --server $SQL_SERVER --name $SQL_DATABASE --service-objective Basic --backup-storage-redundancy Local

# Criar aplicação webapp
az appservice plan create --resource-group $RG_NAME --name $PLAN_NAME --location $LOCATION --sku B1 --is-linux

az webapp create --resource-group $RG_NAME --plan $PLAN_NAME --name $WEBAPP_NAME --runtime "JAVA:21-java21"