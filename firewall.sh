#!/bin/bash
 
RM=566299
LOCATION=chilecentral
RG_NAME=rg-webapp-sql
SQL_SERVER="sql-dimdim-$RM"
SQL_DATABASE=db-dimdim
SQL_ADMIN=user-dimdim
PLAN_NAME=plan-dimdim
WEBAPP_NAME="webapp-sql-dimdim-$RM"

# Liberar regras de acesso
WEBAPP_OUTBOUND_IPS=$(az webapp show --resource-group $RG_NAME --name $WEBAPP_NAME --query outboundIpAddresses --output tsv)

IFS=',' read -ra WEBAPP_IP_LIST <<< "$WEBAPP_OUTBOUND_IPS"

for INDEX in "${!WEBAPP_IP_LIST[@]}"; do
    az sql server firewall-rule-create --resource-group $RG_NAME --server $SQL_SERVER --name "${WEBAPP_NAME}-rule-$INDEX" --start-ip-address "${WEBAPP_IP_LIST[$INDEX]}" --end-ip-address "${WEBAPP_IP_LIST[$INDEX]}" --output none
done