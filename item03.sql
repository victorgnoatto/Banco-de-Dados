--1) Recupere a data de nascimento e o endere�o dos funcion�rios cujo nome seja �Jo�o B. Silva�.

SELECT Datanasc, Endereco 
FROM FUNCIONARIO 
WHERE Pnome='Jo�o' AND Minicial='B' AND Unome='Silva';

--2) Recupere o nome e endere�o de todos os funcion�rios que trabalham para o departamento �Pesquisa�.

SELECT Pnome, Endereco 
FROM FUNCIONARIO, DEPARTAMENTO 
WHERE Dnr = Dnumero AND Dnome = 'Pesquisa'; 

--3) Para cada projeto localizado em �Mau�, liste o n�mero do projeto, o n�mero do departamento que o controla e o sobrenome, endere�o e data de nascimento do gerente do departamento.

SELECT Projnumero, Dnum, Unome, Endereco, Datanasc 
FROM PROJETO, DEPARTAMENTO, FUNCIONARIO 
WHERE Dnum=Dnumero AND Cpf_gerente=Cpf AND Projlocal='Mau�';

--4) Para cada funcion�rio, recupere o primeiro e o �ltimo nome do funcion�rio e o primeiro e o �ltimo nome de seu supervisor imediato.

SELECT em.pnome AS 'Nome do Funcionario', em.unome AS 'Sobrenome do Funcionario', e.pnome AS 'Nome Supervisor',	e.unome AS 'Sobrenome Supervisor' 
FROM FUNCIONARIO AS em, FUNCIONARIO AS e
WHERE em.Cpf_supervisor = e.Cpf;

--5) Consulte todos os Cpfs de FUNCIONARIO

SELECT Cpf FROM FUNCIONARIO;

--6) Consulte Cpf e Dnome (nome de departamento) de cada funcion�rio

SELECT Cpf, Dnome AS 'Nome de Depart' 
FROM FUNCIONARIO, DEPARTAMENTO 
WHERE Dnumero = Dnr;

--7) Recupere todos os valores de sal�rio distintos de funcion�rios.

SELECT DISTINCT salario FROM FUNCIONARIO;

--8) Exiba os n�meros dos projetos que possuem funcion�rio ou gerente com o �ltimo nome �Silva�.

SELECT DISTINCT Projnumero
FROM PROJETO, DEPARTAMENTO, FUNCIONARIO
WHERE Dnum = Dnumero AND Cpf_gerente = Cpf AND Unome= 'Silva'
UNION
SELECT DISTINCT Pnr FROM TRABALHA_EM, FUNCIONARIO
WHERE Fcpf=Cpf AND Unome='Silva';

--9) Recuperar todos os funcion�rios cujo endere�o esteja em �S�o Paulo, SP�.

SELECT Pnome, Minicial, Unome 
FROM FUNCIONARIO 
WHERE Endereco LIKE '%S�o Paulo, SP%';

--10) Encontrar todos os funcion�rios que nasceram durante a d�cada de 1950.

SELECT Pnome, Minicial, Unome 
FROM FUNCIONARIO 
WHERE Datanasc > '1949-12-31' AND Datanasc < '1960-01-01';

--11) Mostrar nome completo do funcion�rio e sal�rio acrescido de 10% dos funcion�rios que trabalham no projeto �ProdutoX�.

SELECT F.Pnome, F.Unome, 1.1 * F.Salario AS 'Salario Aumentado'
FROM FUNCIONARIO AS F, TRABALHA_EM AS T, PROJETO AS P
WHERE F.Cpf = T.Fcpf AND T.Pnr = P.Projnumero AND P.Projnome = 'ProdutoX';

--12)Recuperar nome completo de todos os funcion�rios no departamento 5, cujo sal�rio esteja entre R$ 30.000,00 e R$ 40.000,00

SELECT Pnome, Minicial, Unome, Salario 
FROM FUNCIONARIO
WHERE (Salario >= 30.000 AND Salario <= 40.000) AND  Dnr = 5;

--13) Recuperar nome do departamento, nome completo do funcion�rio e nome do projeto onde ele trabalha, ordenado por departamento, e,
--dentro de cada departamento, ordenado alfabeticamente pelo
--sobrenome, depois pelo nome.

SELECT DISTINCT	Pnome AS 'Nome', Unome AS 'Sobrenome', Dnumero AS 'Departamento', Projnumero AS 'Cod. Projeto', Projnome AS 'Nome Projeto'
FROM FUNCIONARIO AS f, PROJETO AS p, DEPARTAMENTO AS d, TRABALHA_EM AS t
WHERE (f.Dnr = d.Dnumero) AND (t.Fcpf = f.Cpf) AND (p.Projnumero = t.Pnr)
ORDER BY d.Dnumero, f.Unome, f.Pnome;

--14) Recupere os nomes de todos os funcion�rios no departamento 5 que trabalham mais de 10 horas por semana no projeto �ProdutoX�.
SELECT DISTINCT Pnome, Minicial, Unome
FROM FUNCIONARIO, TRABALHA_EM, PROJETO
WHERE Cpf = Fcpf AND Pnr = Projnumero AND Dnr = '5' AND Horas > '10.0' AND Projnome='ProdutoX';

--15) Liste os nomes de todos os funcion�rios que possuem um dependente com o mesmo primeiro nome que seu pr�prio.

SELECT DISTINCT Pnome, Minicial, Unome
FROM FUNCIONARIO, DEPENDENTE
WHERE Cpf = Fcpf AND Pnome = Nome_dependente;

--16) Ache os nomes de todos os funcion�rios que s�o supervisionados diretamente por �Fernando Wong�.

SELECT F1.Pnome, F1.Unome
FROM FUNCIONARIO AS F1, FUNCIONARIO AS F2
WHERE F2.Pnome = 'Fernando' AND F2.Unome = 'Wong' AND F2.Cpf = F1.Cpf_supervisor;

--17) Recuperar os nomes de todos os funcion�rios que n�o possuem supervisores.

SELECT Pnome, Unome
FROM  FUNCIONARIO
WHERE Cpf_supervisor IS NULL;

--19) Exibir os nomes dos funcion�rios cujo sal�rio � maior do que o sal�rio de todos os funcion�rios do departamento de n�mero 5.

SELECT Pnome
FROM FUNCIONARIO
WHERE Salario > ALL
	(SELECT Salario
	FROM FUNCIONARIO
	WHERE Dnr = '5');

--20) Obter o nome de cada funcion�rio que tem um dependente com o mesmo sexo do funcion�rio.

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


--22) Listar os CPFs de todos os funcion�rios que trabalham nos projetos de n�meros 1, 2 ou 3.

SELECT Fcpf AS 'CPF'
FROM TRABALHA_EM
WHERE Pnr = 1 OR Pnr = 2 OR Pnr = 3
ORDER BY Pnr;

--23)Exibir a soma dos sal�rios de todos os funcion�rios, o sal�rio m�ximo, o sal�rio m�nimo e a m�dia dos sal�rios.

SELECT SUM(Salario) AS 'Total de Salarios',
		MAX(Salario) AS 'Maior Salario',
		MIN(Salario) AS 'Menor Salario',
		AVG(Salario) AS 'Media dos Salarios'
FROM FUNCIONARIO;


--24) Exibir a soma dos sal�rios de todos os funcion�rios de cada departamento, bem como o sal�rio m�ximo, o sal�rio m�nimo e a m�dia dos sal�rios de cada um desses departamentos.
--*Pesquisa
SELECT SUM(salario) AS 'Total de Salarios',
		MAX(salario) AS 'Maior Salario',
		MIN(salario) AS 'Menor Salario',
		AVG(salario) AS 'Media dos Salarios'
FROM FUNCIONARIO, DEPARTAMENTO
WHERE Dnr = Dnumero
GROUP BY Dnome;

--25) Recuperar o n�mero total de funcion�rios da empresa.
SELECT COUNT (DISTINCT Cpf) AS 'Numero de Empregados'
FROM FUNCIONARIO;

--26)Recuperar o n�mero de funcion�rios de cada departamento

SELECT COUNT (DISTINCT Cpf) AS 'Numero de Empregados'
FROM FUNCIONARIO, DEPARTAMENTO
WHERE Dnr = Dnumero
GROUP BY Dnome;

--27) Obter o n�mero de valores distintos de sal�rio.
SELECT COUNT (DISTINCT Salario) AS 'Salarios'
FROM FUNCIONARIO;

--28) Exibir os nomes de todos os funcion�rios que possuem dois ou mais dependentes.

SELECT Pnome
FROM FUNCIONARIO as F
WHERE (SELECT COUNT(*)
 FROM DEPENDENTE as D
 WHERE F.Cpf = D.Fcpf) >= 2;

--29) Exibir o n�mero do departamento, o n�mero de funcion�rios no departamento e o sal�rio m�dio do departamento, para cada departamento da empresa.

SELECT Dnr AS 'Numero do Departamento',
		COUNT (*) AS 'Numero de funcionarios',
		AVG (Salario) AS 'Media de Salarios'
FROM DEPARTAMENTO AS d, FUNCIONARIO as f
WHERE Dnr = dnumero
GROUP BY Dnr;


--30) Listar o n�mero do projeto, o nome do projeto e o n�mero de funcion�rios que trabalham nesse projeto, para cada projeto.

SELECT t.Pnr AS 'Numero do Projeto',
	   p.Projnome AS 'Nome do Projeto',
	   COUNT (t.Fcpf) AS 'Numero de funcionarios'
FROM PROJETO AS p, TRABALHA_EM AS t
WHERE t.Pnr = p.Projnumero
GROUP BY t.Pnr, p.Projnome, p.Dnum;

