# Docker_Dev_Web

Ambiente de desenvolvimento com PHP, Composer, Apache2, Mysql, phpMyadmin e Node, dentro do Ubuntu Server. 


## Instalação:
Para realizar a instalação basta realizar a clonagem do repositório.
**HTTPS**

    gh repo clone bulfaitelo/Docker_Dev_Web

**GitHub Cli** 

    git clon https://github.com/bulfaitelo/Docker_Dev_Web.git

## Levantando e derrubando os containers:

    docker-compose up -d

O comando irá compilar os containers e levanta-los, caso já tenha sido compilado irá apenas levantar novamente.
Caso queria derrubar os containers basta executar o comando:

    docker-compose down

## Uso:
Basicamente após levantar o container e só colocar os arquivos em **www** que já vão está funcionando, caso queria rodar algum comando do node ou composer basta acessar o terminal da aplicação: 
basta executar o comando para acessar o terminal do container:

### App:

    docker exec -it app bash

![Terminal do App](https://i.imgur.com/iGl1Out.png)

*Para logar como Root a senha padrão é root, por exemplo `su - root` e a senha também é root, sendo possível alterar dentro `Dockerfile`*

Para logar como Root a senha padrão é root, por exemplo su - root e a senha root### Banco de dados:
O banco de dados replica nome do container que no meu caso é **mysql_db**,

> Então quando for definir o nome do servidor mysql em alguma aplicação
> o nome do servidor vai ser **mysql_db**.

### PhpMyadmin:
Basta acessar o caminho no navegador http://localhost:8080/, por padrão o usuário criado é o **root**, com a senha **root**. 

> Lembrando que é um ambiente de desenvolvimento eu particularmente não
> recomendo usar em ambiente de produção.

## Diretórios:
O ambiente foi dividido em **conf, dbdata, docker, logs e www**, abaixo irei descrever como foram organizados:
![Vs Code exemplo: ](https://i.imgur.com/eTZN8py.png)

### www:
Diretório de trabalho, já vem 3 arquivos de testes:
**info.php**: Carregando a função `phpinfo();`;
**error.php**: Basicamente gerando um erro na tela para testar a geração de log;
**mysql.php**: Testando a conexão com o banco de dados MySQL. 

### conf: 
Contem 3 subdiretórios **apache**, **mysql** e **ubuntu** respectivamente responsáveis por suas funções: 
#### apache:
Contendo 2 subdiretórios **php**, contendo o **php.ini** e suas configurações personalizadas e o diretório **vhost** contendo o arquivo **vhost.conf**, nele é possível cadastrar os virtual hosts do Apache. 

#### mysql:
Contendo **my.cnf** com uma configuração bem básica, passível de personalização; 

#### ubuntu:
Contem o arquivo de **.bashrc** com as personalizações de terminal e auto complete. 

### dbdata:
Diretório responsável por salvar os arquivos do banco de dados, caso não queira usar comente a linha responsável no **docker-compose.yml**.

### docker:
Responsável por conter os **Dockerfile** para levantar os containers, esse diretório é subdividido em 3 **mysql**, **phpmyadmin** e **ubuntu**, o mysql e phpmyadmin estão apenas as requisições de instalação, o ubuntu é onde são instalado o node, composer, php e etc.

O diretório **docker/ubuntu** foi alterado para que possa existir diferentes versões do php apenas alterando o arquivo no `dockercomposer.yml`, por exemplo `Dockerfile.php.latest` irá trazer sempre a versão mais atualizada do ubuntu e php. 

### logs:
subdividido em **apache** e **php** e sendo responsáveis respectivamente por salvar esses logs. 

## Conclusão:
Esse ambiente foi inicialmente montado para quem esta migrando do Wamp para um ambiente Docker e quer ter a facilidade de rodar um comando e ter o ambiente pronto. conforme forem surgindo necessidades irei melhorando e corrigindo possíveis bugs.
