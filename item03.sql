--1) Recupere a data de nascimento e o endereço dos funcionários cujo nome seja ‘João B. Silva’.

SELECT Datanasc, Endereco 
FROM FUNCIONARIO 
WHERE Pnome='João' AND Minicial='B' AND Unome='Silva';

--2) Recupere o nome e endereço de todos os funcionários que trabalham para o departamento ‘Pesquisa’.

SELECT Pnome, Endereco 
FROM FUNCIONARIO, DEPARTAMENTO 
WHERE Dnr = Dnumero AND Dnome = 'Pesquisa'; 

--3) Para cada projeto localizado em ‘Mauá’, liste o número do projeto, o número do departamento que o controla e o sobrenome, endereço e data de nascimento do gerente do departamento.

SELECT Projnumero, Dnum, Unome, Endereco, Datanasc 
FROM PROJETO, DEPARTAMENTO, FUNCIONARIO 
WHERE Dnum=Dnumero AND Cpf_gerente=Cpf AND Projlocal='Mauá';

--4) Para cada funcionário, recupere o primeiro e o último nome do funcionário e o primeiro e o último nome de seu supervisor imediato.

SELECT em.pnome AS 'Nome do Funcionario', em.unome AS 'Sobrenome do Funcionario', e.pnome AS 'Nome Supervisor',	e.unome AS 'Sobrenome Supervisor' 
FROM FUNCIONARIO AS em, FUNCIONARIO AS e
WHERE em.Cpf_supervisor = e.Cpf;

--5) Consulte todos os Cpfs de FUNCIONARIO

SELECT Cpf FROM FUNCIONARIO;

--6) Consulte Cpf e Dnome (nome de departamento) de cada funcionário

SELECT Cpf, Dnome AS 'Nome de Depart' 
FROM FUNCIONARIO, DEPARTAMENTO 
WHERE Dnumero = Dnr;

--7) Recupere todos os valores de salário distintos de funcionários.

SELECT DISTINCT salario FROM FUNCIONARIO;

--8) Exiba os números dos projetos que possuem funcionário ou gerente com o último nome ‘Silva’.

SELECT DISTINCT Projnumero
FROM PROJETO, DEPARTAMENTO, FUNCIONARIO
WHERE Dnum = Dnumero AND Cpf_gerente = Cpf AND Unome= 'Silva'
UNION
SELECT DISTINCT Pnr FROM TRABALHA_EM, FUNCIONARIO
WHERE Fcpf=Cpf AND Unome='Silva';

--9) Recuperar todos os funcionários cujo endereço esteja em ‘São Paulo, SP’.

SELECT Pnome, Minicial, Unome 
FROM FUNCIONARIO 
WHERE Endereco LIKE '%São Paulo, SP%';

--10) Encontrar todos os funcionários que nasceram durante a década de 1950.

SELECT Pnome, Minicial, Unome 
FROM FUNCIONARIO 
WHERE Datanasc > '1949-12-31' AND Datanasc < '1960-01-01';

--11) Mostrar nome completo do funcionário e salário acrescido de 10% dos funcionários que trabalham no projeto ‘ProdutoX’.

SELECT F.Pnome, F.Unome, 1.1 * F.Salario AS 'Salario Aumentado'
FROM FUNCIONARIO AS F, TRABALHA_EM AS T, PROJETO AS P
WHERE F.Cpf = T.Fcpf AND T.Pnr = P.Projnumero AND P.Projnome = 'ProdutoX';

--12)Recuperar nome completo de todos os funcionários no departamento 5, cujo salário esteja entre R$ 30.000,00 e R$ 40.000,00

SELECT Pnome, Minicial, Unome, Salario 
FROM FUNCIONARIO
WHERE (Salario >= 30.000 AND Salario <= 40.000) AND  Dnr = 5;

--13) Recuperar nome do departamento, nome completo do funcionário e nome do projeto onde ele trabalha, ordenado por departamento, e,
--dentro de cada departamento, ordenado alfabeticamente pelo
--sobrenome, depois pelo nome.

SELECT DISTINCT	Pnome AS 'Nome', Unome AS 'Sobrenome', Dnumero AS 'Departamento', Projnumero AS 'Cod. Projeto', Projnome AS 'Nome Projeto'
FROM FUNCIONARIO AS f, PROJETO AS p, DEPARTAMENTO AS d, TRABALHA_EM AS t
WHERE (f.Dnr = d.Dnumero) AND (t.Fcpf = f.Cpf) AND (p.Projnumero = t.Pnr)
ORDER BY d.Dnumero, f.Unome, f.Pnome;

--14) Recupere os nomes de todos os funcionários no departamento 5 que trabalham mais de 10 horas por semana no projeto ‘ProdutoX’.
SELECT DISTINCT Pnome, Minicial, Unome
FROM FUNCIONARIO, TRABALHA_EM, PROJETO
WHERE Cpf = Fcpf AND Pnr = Projnumero AND Dnr = '5' AND Horas > '10.0' AND Projnome='ProdutoX';

--15) Liste os nomes de todos os funcionários que possuem um dependente com o mesmo primeiro nome que seu próprio.

SELECT DISTINCT Pnome, Minicial, Unome
FROM FUNCIONARIO, DEPENDENTE
WHERE Cpf = Fcpf AND Pnome = Nome_dependente;

--16) Ache os nomes de todos os funcionários que são supervisionados diretamente por ‘Fernando Wong’.

SELECT F1.Pnome, F1.Unome
FROM FUNCIONARIO AS F1, FUNCIONARIO AS F2
WHERE F2.Pnome = 'Fernando' AND F2.Unome = 'Wong' AND F2.Cpf = F1.Cpf_supervisor;

--17) Recuperar os nomes de todos os funcionários que não possuem supervisores.

SELECT Pnome, Unome
FROM  FUNCIONARIO
WHERE Cpf_supervisor IS NULL;

--19) Exibir os nomes dos funcionários cujo salário é maior do que o salário de todos os funcionários do departamento de número 5.

SELECT Pnome
FROM FUNCIONARIO
WHERE Salario > ALL
	(SELECT Salario
	FROM FUNCIONARIO
	WHERE Dnr = '5');

--20) Obter o nome de cada funcionário que tem um dependente com o mesmo sexo do funcionário.

SELECT F.Pnome, F.Unome
FROM FUNCIONARIO AS F
WHERE F.Cpf IN 
	(SELECT D.Fcpf
	FROM DEPENDENTE AS D
	WHERE F.Pnome = D.Nome_dependente AND F.Sexo = D.Sexo);

--21) Listar os nomes dos gerentes que possuem pelo menos um dependente.

SELECT F.Pnome
FROM FUNCIONARIO AS F
WHERE EXISTS (SELECT * FROM DEPENDENTE AS D WHERE D.Fcpf = F.Cpf)
 AND EXISTS (SELECT * FROM DEPARTAMENTO WHERE F.Cpf = Departamento.Cpf_gerente);


--22) Listar os CPFs de todos os funcionários que trabalham nos projetos de números 1, 2 ou 3.

SELECT Fcpf AS 'CPF'
FROM TRABALHA_EM
WHERE Pnr = 1 OR Pnr = 2 OR Pnr = 3
ORDER BY Pnr;

--23)Exibir a soma dos salários de todos os funcionários, o salário máximo, o salário mínimo e a média dos salários.

SELECT SUM(Salario) AS 'Total de Salarios',
		MAX(Salario) AS 'Maior Salario',
		MIN(Salario) AS 'Menor Salario',
		AVG(Salario) AS 'Media dos Salarios'
FROM FUNCIONARIO;


--24) Exibir a soma dos salários de todos os funcionários de cada departamento, bem como o salário máximo, o salário mínimo e a média dos salários de cada um desses departamentos.
--*Pesquisa
SELECT SUM(salario) AS 'Total de Salarios',
		MAX(salario) AS 'Maior Salario',
		MIN(salario) AS 'Menor Salario',
		AVG(salario) AS 'Media dos Salarios'
FROM FUNCIONARIO, DEPARTAMENTO
WHERE Dnr = Dnumero
GROUP BY Dnome;

--25) Recuperar o número total de funcionários da empresa.
SELECT COUNT (DISTINCT Cpf) AS 'Numero de Empregados'
FROM FUNCIONARIO;

--26)Recuperar o número de funcionários de cada departamento

SELECT COUNT (DISTINCT Cpf) AS 'Numero de Empregados'
FROM FUNCIONARIO, DEPARTAMENTO
WHERE Dnr = Dnumero
GROUP BY Dnome;

--27) Obter o número de valores distintos de salário.
SELECT COUNT (DISTINCT Salario) AS 'Salarios'
FROM FUNCIONARIO;

--28) Exibir os nomes de todos os funcionários que possuem dois ou mais dependentes.

SELECT Pnome
FROM FUNCIONARIO as F
WHERE (SELECT COUNT(*)
 FROM DEPENDENTE as D
 WHERE F.Cpf = D.Fcpf) >= 2;

--29) Exibir o número do departamento, o número de funcionários no departamento e o salário médio do departamento, para cada departamento da empresa.

SELECT Dnr AS 'Numero do Departamento',
		COUNT (*) AS 'Numero de funcionarios',
		AVG (Salario) AS 'Media de Salarios'
FROM DEPARTAMENTO AS d, FUNCIONARIO as f
WHERE Dnr = dnumero
GROUP BY Dnr;


--30) Listar o número do projeto, o nome do projeto e o número de funcionários que trabalham nesse projeto, para cada projeto.

SELECT t.Pnr AS 'Numero do Projeto',
	   p.Projnome AS 'Nome do Projeto',
	   COUNT (t.Fcpf) AS 'Numero de funcionarios'
FROM PROJETO AS p, TRABALHA_EM AS t
WHERE t.Pnr = p.Projnumero
GROUP BY t.Pnr, p.Projnome, p.Dnum;

