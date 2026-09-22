#!/bin/bash

# Deploy da aplicação
az webapp deploy --resource-group $RG_NAME --name $WEBAPP_NAME --scr-path ../transacoes-3/target/transacoes..jar --type jar