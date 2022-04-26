
# POSTGRES SQL:



primeiro criei o user com `CREATE USER arthur WITH PASSWORD 'senha';
GRANT ALL PRIVILEGES ON . TO 'arthur'@localhost;`
Logo apos criei o banco de dados `CREATE database uvv 
WITH
owner = arthur
encoding = 'UTF8'
template = template0
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8'
ALLOW_CONNECTIONS = TRUE;´

apos isso criei o schema:


`CREATE SCHEMA IF NOT EXISTS elmasri 
    AUTHORIZATION arthur;
grant ALL PRIVILEGES ON ALL tables IN SCHEMA elmasri TO sthefany;
SET search_path TO elmasri, "$user", public;`

Sendo assim digitei:
`\c uvv`
e colei o script do Architect, apos isso passei tudo para o DBver, e voltei a o terminal, e coloquei os dados dentro das colunas com o `INSERT INTO`


# MARIADB:



Primeiro criei o user com CREATE USER `'arthur'@localhost IDENTIFIED BY 'senha';` e garanti os privilegios com `GRANT ALL PRIVILEGES ON *.* TO 'user1'@localhost IDENTIFIED BY 'password1';`
logo apos digitei `CREATE DATABASE uvv;`
use uvv;
e colei todo o script do Architect, apos isso coloquei todos os dados das colunas.
