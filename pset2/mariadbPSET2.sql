1) from funcionario WHERE numero_departamento = 5; 

from funcionario WHERE numero_departamento = 4; 

from funcionario WHERE numero_departamento = 1; 

2) 

SELECT AVG(salario) from funcionario WHERE sexo = 'M'; 

SELECT AVG(salario) from funcionario WHERE sexo = 'F'; 

 

3) 

SELECT primeiro_nome, nome_meio, ultimo_nome, nome_departamento, salario, data_nascimento, year(curdate()) - year(funcionario.data_nascimento) as idade from departamento, funcionario where departamento.numero_departamento = funcionario.numero_departamento; 

 

4) select primeiro_nome, nome_meio, ultimo_nome, salario , case salario 

WHEN salario <= 35000 THEN salario*1.20 

ELSE salario*1.15 

END AS reajuste 

FROM funcionario; 

 

5) SELECT departamento.nome_departamento, funcionario.primeiro_nome,  funcionario.nome_meio, funcionario.ultimo_nome, funcionario.salario, departamento.cpf_gerente, case departamento.cpf_gerente WHEN '33344555587' then 'João' WHEN '98765432168' then  'André' WHEN '88866555576' then 'Fernando' END as gerente from  (funcionario, dependente, departamento)   INNER JOIN departamento as d ON (funcionario.cpf = d.cpf_gerente)   INNER JOIN dependente as dpn ON (funcionario.cpf = dpn.cpf_funcionario)   WHERE d.cpf_gerente = dpn.cpf_funcionario   group by departamento.nome_departamento, funcionario.primeiro_nome, funcionario.nome_meio, funcionario.ultimo_nome, funcionario.salario, departamento.cpf_gerente; 

 

 

 

6)  

select funcionario.primeiro_nome as funcionario , dependente.nome_dependente, dependente.data_nascimento, dependente.cpf_funcionario, year(curdate()) - year(dependente.data_nascimento) as idade, case dependente.sexo WHEN 'M' THEN 'Masculino' WHEN 'F' THEN 'Feminino' END as sexo from (dependente, funcionario) LEFT JOIN funcionario as f ON (dependente.cpf_funcionario = f.cpf) INNER JOIN departamento as d ON (funcionario.numero_departamento = d.numero_departamento) where funcionario.cpf = dependente.cpf_funcionario  group by funcionario.primeiro_nome,  dependente.nome_dependente, dependente.sexo, dependente.cpf_funcionario; 

 

7)  

SELECT funcionario.primeiro_nome as funcionario, funcionario.numero_departamento, funcionario.salario from funcionario LEFT JOIN dependente ON funcionario.cpf = dependente.cpf_funcionario INNER JOIN departamento ON funcionario.numero_departamento = departamento.numero_departamento WHERE dependente.cpf_funcionario is NULL; 

 

8) SELECT departamento.nome_departamento, projeto.numero_projeto, funcionario.primeiro_nome, funcionario.nome_meio, funcionario.ultimo_nome, trabalha_em.horas from (funcionario, projeto, departamento, trabalha_em) 

INNER JOIN departamento as d ON (departamento.numero_departamento = funcionario.numero_departamento) 

INNER JOIN trabalha_em as t ON (trabalha_em.numero_projeto = projeto.numero_projeto) 

INNER JOIN projeto as p ON (projeto.numero_do_departamento = departamento.numero_departamento) 

INNER JOIN trabalha_em as trab ON (trabalha_em.cpf_funcionario = funcionario.cpf) 

group by departamento.nome_departamento, projeto.numero_projeto, funcionario.primeiro_nome, funcionario.nome_meio, funcionario.ultimo_nome, trabalha_em.horas, departamento.numero_departamento, trabalha_em.numero_projeto, projeto.numero_do_departamento, funcionario.cpf ; 

 

9) 

SELECT projeto.nome_projeto, projeto.numero_projeto, departamento.nome_departamento, SUM(horas)  from (trabalha_em, projeto, departamento) 

INNER JOIN projeto as p ON projeto.numero_projeto =  trabalha_em.numero_projeto 

group by projeto.nome_projeto, departamento.nome_departamento ; 

 

10) select funcionario.numero_departamento, AVG(salario) from funcionario where numero_departamento group by numero_departamento; 

 

 

11)SELECT funcionario.primeiro_nome, funcionario.nome_meio, funcionario.ultimo_nome, funcionario.salario, trabalha_em.cpf_funcionario, projeto.nome_projeto, trabalha_em.horas*50, funcionario.numero_departamento from (funcionario, projeto, trabalha_em, departamento) 

INNER JOIN funcionario as f ON (funcionario.cpf = trabalha_em.cpf_funcionario) 

INNER JOIN projeto as p ON (projeto.numero_projeto = trabalha_em.numero_projeto) 

 

group by funcionario.primeiro_nome, funcionario.nome_meio, funcionario.ultimo_nome, funcionario.salario; 

 

 

 

 

12) SELECT departamento.nome_departamento, projeto.nome_projeto, funcionario.primeiro_nome, funcionario.nome_meio, funcionario.ultimo_nome, trabalha_em.horas  

  

 from (departamento, projeto, funcionario, trabalha_em)  

 INNER JOIN trabalha_em as t ON (trabalha_em.cpf_funcionario = funcionario.cpf)  

 INNER JOIN funcionario as f ON (funcionario.numero_departamento = departamento.numero_departamento)  

INNER JOIN projeto AS p ON (departamento.numero_departamento = projeto.numero_do_departamento) 

 WHERE trabalha_em.horas = 0  

 group by  departamento.nome_departamento, projeto.numero_projeto, projeto.numero_do_departamento; 

 

 

 

 

 

 

13) 

 

SELECT funcionario.primeiro_nome as nome, funcionario.nome_meio, funcionario.ultimo_nome, funcionario.sexo, year(curdate()) - year(funcionario.data_nascimento) as idade from funcionario  UNION SELECT dependente.nome_dependente as nome, funcionario.nome_meio, funcionario.ultimo_nome, dependente.sexo, year(curdate()) - year(dependente.data_nascimento) as idade from (funcionario, dependente)  

   where funcionario.cpf = dependente.cpf_funcionario 

Order by idade desc; 

 

     

 

 

 

 

 

 

14) select funcionario.numero_departamento, COUNT(numero_departamento) from funcionario where numero_departamento group by numero_departamento; 

 

 

 

 

 15) SELECT funcionario.primeiro_nome, funcionario.nome_meio, funcionario.ultimo_nome, funcionario.numero_departamento, projeto.nome_projeto from (projeto, funcionario, trabalha_em, departamento) 

INNER JOIN trabalha_em as trab ON (trabalha_em.cpf_funcionario = funcionario.cpf) 

INNER JOIN funcionario as f ON (f.numero_departamento = projeto.numero_do_departamento) 

INNER JOIN trabalha_em as t ON (trabalha_em.numero_projeto = projeto.numero_projeto)  

 

 

group by projeto.numero_projeto, trabalha_em.cpf_funcionario,  trabalha_em.numero_projeto, projeto.nome_projeto, funcionario.numero_departamento ; 