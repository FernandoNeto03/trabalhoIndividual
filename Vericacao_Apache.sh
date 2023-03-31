#!/bin/bash

#Mostrar data e hora atual
horarioAtual=$(date +"%Y-%m-%d %H:%M:%S")

#Verificar se o servidor Apache está funcionando
status_Servidor=" "

if systemctl is-active --quiet httpd; then
	status_Servidor="online"
	mensagem_Personalizada="Eba! O seu servidor está online e funcionando!"
else
	status_Servidor="offline"
	mensagem_Personalizada="Ops! O seu servidor está offline e não está funcionando."
fi

#Resposta completa com informações
resposta_Log="\nHora Atual: ${horarioAtual} \nStatus do Apache: ${status_Servidor} ${mensagem_Personalizada}"

#Gerando os arquivos de saída
if [ "${status_Servidor}"=="online" ];then
        echo "${resposta_Log}" >> /efs/fernando/Servidor_online.log
else
        echo "${resposta_Log}" >> /efs/fernando/Servidor_offline.log
fi
