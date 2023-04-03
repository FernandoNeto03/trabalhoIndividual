# Projeto Compass
## Criação de uma instância com EFS na Amazon Web Services(AWS), configuração do apache e geração de um script para retornar o status do servidor.


### **Primeiro, vamos criar a instância, no nosso caso, com o nome de `PB UNIVEST URI`:**

### **Informações da instância:**

- _**SO: Amazon Linux 2**_
- _**Família: t3.small**_
- _**Volume: 1x16GB gp2**_


**Portas liberadas no Security Group:**
* _**22/TCP - SSH**_
* _**111/TCP**_ **- Usado para mapear portas RPC não registradas**
* _**111/UDP**_ **- Usado para mapear portas RPC não registradas**
* _**2049/TCP - NFS**_
* _**2049/UDP - NFS**_
* _**80/TCP - HTTP**_
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
    
    
    
