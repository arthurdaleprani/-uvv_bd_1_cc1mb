create user arthur with encrypted password 'senha';
alter user arthur createdb;
create schema if not exists elmasri
authorization arthur;

grant all privileges on all tables in schema elmasri to arthur;
set search_path to elmasri, "\$user", public;
psql -u arthur postgres -w

create database UVV
with
owner = arthur
encoding = 'UTF8'
template = template0
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8'
ALLOW_CONNECTIONS = true;

ALTER USER arthur
uvv-# SET SEARCH_PATH TO elmasri, "$user", public;
SHOW SEARCH_PATH;

\c uvv;





CREATE TABLE elmasri.funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(100),
                sexo CHAR(1),
                salario NUMERIC(10,2),
                cpf_supervisor CHAR(11) NOT NULL,
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT cpf PRIMARY KEY (cpf)
);


COMMENT ON TABLE elmasri.funcionario IS 'Tabela que armazena as informações dos funcionários.';
COMMENT ON COLUMN elmasri.funcionario.cpf IS 'CPF do funcionário. Será a PK da tabela.';
COMMENT ON COLUMN elmasri.funcionario.primeiro_nome IS 'Primeiro nome do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.nome_meio IS 'Inicial do nome do meio.';
COMMENT ON COLUMN elmasri.funcionario.ultimo_nome IS 'Sobrenome do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.endereco IS 'Endereço do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.sexo IS 'Sexo do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.salario IS 'Salário do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.cpf_supervisor IS 'CPF do supervisor. Será uma FK para a própria tabela (um auto-relacionamento).';
COMMENT ON COLUMN elmasri.funcionario.numero_departamento IS 'Número do departamento do funcionário.';

insert into elmasri.funcionario (
cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
values ('12345678966', 'João', 'B', 'Silva', '01-09-1965', 'Rua das Flores, 751, São Paulo, SP', 'M', '30000', '33344555587', '5'),
('33344555587', 'Fernando', 'T', 'Wong', '12-08-1955', 'Rua da Lapa, 34, São Paulo, SP', 'M', '40000', '88866555576', '5' ),
('99988777767', 'Alice', 'J', 'Zelaya', '01-19-1968', 'Rua Souza Lima, 35, CUritiba, PR', 'F', '25000', '98765432168', '4'),
('98765432168', 'Jennifer', 'S', 'Souza', '06-20-1941', 'Av. Arthur de Lima, 54, Snato André, SP', 'F', '43000', '88866555576', '4'),
('66688444476', 'Ronaldo', 'K', 'Lima', '09-15-1962', 'Rua Rebouças, 65, Piracicaba, SP', 'M', '38000', '33344555587', '5'),
('45345345376', 'Joice', 'A', 'Leite', '07-31-1972', 'Av. Lucas Obes, 74, São Paulo, SP', 'F', '25000', '33344555587', '5'),
('98798798733', 'André', 'V', 'Pereira', '03-29-1969', 'Rua Timbira, 35, São Paulo, SP', 'M', '25000', '98765432168', '4'),
('88866555576', 'Jorge', 'E', 'Brito', '11-10-1937', 'Rua do Horto, 35, São Paulo, SP', 'M', '55000', '88866555576', '1'); 


CREATE TABLE elmasri.departamento (
                numero_departamento INTEGER NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                CONSTRAINT numero_departamento PRIMARY KEY (numero_departamento)
);
COMMENT ON TABLE elmasri.departamento IS 'Tabela que armazena as informaçoẽs dos departamentos.';
COMMENT ON COLUMN elmasri.departamento.numero_departamento IS 'Número do departamento. É a PK desta tabela.';
COMMENT ON COLUMN elmasri.departamento.nome_departamento IS 'Nome do departamento. Deve ser único.';
COMMENT ON COLUMN elmasri.departamento.cpf_gerente IS 'CPF do gerente do departamento. É uma FK para a tabela funcionários.';
COMMENT ON COLUMN elmasri.departamento.data_inicio_gerente IS 'Data do início do gerente no departamento.';

insert into elmasri.departamento (
numero_departamento, nome_departamento, cpf_gerente, data_inicio_gerente)
values ('5', 'Pesquisa', '33344555587', '05-22-1988'),
('4', 'Administração', '98765432168', '01-01-1995'),
('1', 'Matriz', '88866555576', '06-19-1981');

CREATE UNIQUE INDEX departamento_idx
 ON elmasri.departamento
 ( nome_departamento );

CREATE TABLE elmasri.projeto (
                numero_projeto INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_do_departamento INTEGER NOT NULL,
                CONSTRAINT numero_projeto PRIMARY KEY (numero_projeto)
);
COMMENT ON TABLE elmasri.projeto IS 'Tabela que armazena as informações sobre os projetos dos departamentos.';
COMMENT ON COLUMN elmasri.projeto.numero_projeto IS 'Número do projeto. É a PK desta tabela.';
COMMENT ON COLUMN elmasri.projeto.nome_projeto IS 'Nome do projeto. Deve ser único.';
COMMENT ON COLUMN elmasri.projeto.local_projeto IS 'Localização do projeto.';
COMMENT ON COLUMN elmasri.projeto.numero_do_departamento IS 'Número do departamento. É uma FK para a tabela departamento.';

insert into elmasri.projeto (
numero_projeto, nome_projeto, local_projeto, numero_do_departamento)
values ('1', 'ProdutoX', 'Santo André', '5'),
('2', 'ProdutoY', 'Itu', '5'),
('3', 'ProdutoZ', 'São Paulo', '5'),
('10', 'INformatização', 'Mauá', '4'),
('20', 'Reorganização', 'São Paulo', '1'),
('30', 'Novosbenefícios', 'Mauá', '4');

CREATE UNIQUE INDEX projeto_idx
 ON elmasri.projeto
 ( nome_projeto );

CREATE TABLE elmasri.localizacoes_de_departamento (
                numero_departamento INTEGER NOT NULL,
                local VARCHAR(15) NOT NULL,
                CONSTRAINT local PRIMARY KEY (numero_departamento, local)
);
COMMENT ON TABLE elmasri.localizacoes_de_departamento IS 'Tabela que armazena as possíveis localizações dos departamentos.';
COMMENT ON COLUMN elmasri.localizacoes_de_departamento.numero_departamento IS 'Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.';
COMMENT ON COLUMN elmasri.localizacoes_de_departamento.local IS 'Localização do departamento. Faz parte da PK desta tabela.';



CREATE TABLE elmasri.trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1) NOT NULL,
                CONSTRAINT cpf_funcionario PRIMARY KEY (cpf_funcionario, numero_projeto)
);
COMMENT ON TABLE elmasri.trabalha_em IS 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
COMMENT ON COLUMN elmasri.trabalha_em.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN elmasri.trabalha_em.numero_projeto IS 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.';
COMMENT ON COLUMN elmasri.trabalha_em.horas IS 'Horas trabalhadas pelo funcionário neste projeto.';

insert into elmasri.trabalha_em (
cpf_funcionario, numero_projeto, horas)
values ('12345678966', '1', '32.5'),
('12345678966', '2', '7.5'),
('66688444476', '3', '40'),
('45345345376', '1', '20'),
('45345345376', '2', '20'),
('33344555587', '2', '10'),
('33344555587', '3', '10'),
('33344555587', '10', '10'),
('33344555587', '20', '10'),
('99988777767', '30', '30'),
('99988777767', '10', '10'),
('98798798733', '10', '35'),
('98798798733', '30', '5'),
('98765432168', '30', '20'),
('98765432168', '20', '15'),
('88866555576', '20', '0');


CREATE TABLE elmasri.dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                PRIMARY KEY (cpf_funcionario, nome_dependente)
);
COMMENT ON TABLE elmasri.dependente IS 'Tabela que armazena as informações dos dependentes dos funcionários.';
COMMENT ON COLUMN elmasri.dependente.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN elmasri.dependente.nome_dependente IS 'Nome do dependente. Faz parte da PK desta tabela.';
COMMENT ON COLUMN elmasri.dependente.sexo IS 'Sexo do dependente.';
COMMENT ON COLUMN elmasri.dependente.data_nascimento IS 'Data de nascimento do dependente.';
COMMENT ON COLUMN elmasri.dependente.parentesco IS 'Descrição do parentesco do dependente com o funcionário.';

insert into elmasri.dependente(
cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values ('33344555587', 'Alicia', 'F', '04-05-1986', 'Filha'),
('33344555587', 'Tiago', 'M', '10-25-1983', 'Filho'),
('33344555587', 'Janaína', 'F', '05-03-1958', 'Esposa'),
('98765432168', 'Antonio', 'M', '02-28-1942', 'Marido'),
('12345678966', 'Michael', 'M', '01-04-1988', 'Filho'),
('12345678966', 'Alicia', 'F', '12-30-1988', 'Filha'),
('12345678966', 'Elizabeth', 'F', '05-05-1967', 'Esposa');


ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk1
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.localizacoes_de_departamento ADD CONSTRAINT departamento_localizacoes_de_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_do_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;