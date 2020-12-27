-- Qual a média salarial nessa empresa?
SELECT avg(salario) AS media_salario FROM empregado 
-- R. 35125.000000000000

-- Quantos empregados do departamento 5 trabalham mais de 10h por semana no projeto chamado "ProductX"?
SELECT
   count(empregado.pnome) AS qtd_empregados,
   departamento.dnumero,
   avg(trabalha_em.horas) AS media_horas,
   projeto.pjnome   
FROM empregado
INNER JOIN departamento	ON	empregado.dno	= departamento.dnumero
INNER JOIN trabalha_em	ON	empregado.ssn	= trabalha_em.essn
INNER JOIN projeto	    ON	projeto.pnumero	= trabalha_em.pno
WHERE departamento.dnumero	= 5
AND	trabalha_em.horas		> 10
AND	projeto.pjnome			= 'ProductX'
GROUP BY departamento.dnumero,
         projeto.pjnome 
-- R. 2

-- Quantos empregados possuem um dependente com o mesmo primeiro nome que o deles?
SELECT
    count(empregado.pnome) AS mesmo_nome
FROM empregado
INNER JOIN dependente ON empregado.pnome = dependente.nome_dependente
-- R. 0

-- Quais os nomes de todos os empregados que são diretamente supervisionados por Franklin Wong
SELECT
    empregado.pnome AS colaborador,
    concat(supervisor.pnome, ' ',supervisor.unome) AS lider
FROM empregado
INNER JOIN	empregado AS supervisor ON empregado.superssn = supervisor.ssn
WHERE concat(supervisor.pnome, ' ',supervisor.unome) = 'Franklin Wong'
-- R. Joyce e Ramesh 

-- Quem é a pessoa que possui mais tempo de alocação no projeto 'Newbenefits'?
SELECT
    empregado.pnome,
    projeto.pjnome,
    trabalha_em.horas    
FROM empregado
INNER JOIN departamento	ON	empregado.dno =	departamento.dnumero
INNER JOIN trabalha_em	ON	empregado.ssn =	trabalha_em.essn
INNER JOIN projeto		ON	projeto.pnumero	= trabalha_em.pno
WHERE projeto.pjnome = 'Newbenefits'
ORDER BY trabalha_em.horas DESC
-- R. Alicia

-- Qual é a soma dos salários de todos os empregados do departamento chamado 'Research'?
SELECT
    sum(empregado.salario) as Salario_Total,
    departamento.dnome
FROM empregado
inner JOIN departamento	ON	empregado.dno =	departamento.dnumero
WHERE departamento.dnome = 'Research'
group by departamento.dnome
-- R. 133000.00

-- Qual seria o custo do projeto com folha salarial (soma de todos os salários) caso a 
--empresa desse 10% de aumento para todos os empregados que trabalham no projeto 'ProductX'?
SELECT
   count(empregado.pnome) AS qtd_empregados,
   sum(empregado.salario)*1.1 AS custo_projeto,
    projeto.pjnome   
FROM empregado
inner JOIN projeto ON projeto.pnumero = empregado.dno
AND	projeto.pjnome = 'ProductX'
GROUP BY projeto.pjnome 
-- R. 60500.000

-- Qual o nome do departamento com a menor média de salário entre seus funcionários?
SELECT
   departamento.dnome AS departamento,
   AVG(empregado.salario) AS media_salario
FROM empregado
INNER JOIN departamento	ON	empregado.dno =	departamento.dnumero
GROUP BY departamento.dnome
ORDER BY media_salario ASC
-- R. Administration