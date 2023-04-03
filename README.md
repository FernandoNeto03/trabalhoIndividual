# Projeto Compass
## Criação de uma instância com EFS na Amazon Web Services(AWS), configuração do apache e geração de um script para retornar o status do servidor.


### **Primeiro, vamos criar a instância, no nosso caso, com o nome de `PB UNIVEST URI`:**

### **Informações da instância:**

- _**SO: Amazon Linux 2**_
- _**Família: t3.small**_
- _**Volume: 1x16GB gp2**_


**Portas liberadas no Security Group:**
* _**22/TCP - SSH**_
* _**80/TCP - HTTP**_
* _**111 TCP/UDP**_ **- Usado para mapear portas RPC não registradas**
* _**2049 TCP/UDP - NFS**_
* _**443/TCP - HTTPS**_
 
- **Par de Chaves:**
 _RSA_
 
- **IP Elástico:**
 _52.203.94.200_
 
 - **userdata:**
 
    #!/bin/bash  
    yum update -y `busca todos os pacotes instalados no sistema e os atualiza automaticamente`
    
    yum install httpd -y `instalação do Apache` 
    
    systemctl enable httpd && systemctl start httpd `inicia o Apache`
    
    sudo yum install -y amazon-efs-utils `Instala os arquivos necessários para o EFS`
    
    mkdir /efs  `cria a pasta necessária`
    
    sudo mount -t efs -o tls fs-xxxxxxxxxxxxx:/ /efs `monta o EFS, substituindo os "x" pelo seu código de EFS`
    
    
    
### **Após criada a instância, vamos para a parte de Linux**

### **Acesse sua instância via chave SSH**

1. Acesse o diretório root com `/efs` e crie o script `Verificacao_Apache.sh`;
2. Para que o EFS monte automaticamente quando inicializar a instância, sem precisar refazê-lo sempre, é necessário colocá-lo no arquivo fstab. Abra o arquivo `/etc/fstab` com a função de edição de texto executando o comando `sudo vi /etc/fstab` e inserindo o comando `fs-XXXXXXXX:/ /efs efs defaults,_netdev 0 0` em uma nova linha;
3. Podemos fazer a verificação se o EFS está montado corretamente, utilizando o comando `df -h` e encontrando o volume do mesmo.
4. Para dar a permissão correta, execute `sudo chmod +x Verificacao_Apache.sh`;
5. Devemos colocar nosso cript em uma função de loop para a execução de 5 em 5 minutos do mesmo, utilizando a função do pacote `crond`, o qual ja vem instalado por padrão. Para isso, utilizaremos o comando `crontab -e`. Dentro do arquivo aberto, colocaremos a seguinte linha: `*/5 * * * *  bash /home/efs/Verificacao_Apache.sh`,
onde cada asterísco representa uma medida de tempo, sendo assim, respectivamente, _minuto, hora, dia do mês, mês, dia da semana_.



