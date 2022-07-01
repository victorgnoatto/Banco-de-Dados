-- Povoe o banco de dados com os dados da figura a seguir. Os dados devem ser inseridos no mesmo arquivo. Salvar como item02.sql.

INSERT INTO DEPARTAMENTO (Dnome, Dnumero, Cpf_gerente, Data_inicio_gerente)
VALUES
('Pesquisa', '5', '33344555587', '22-05-1988'),
('Administração', '4', '98765432168', '01-01-1995'),
('Matriz', '1', '88866555576', '19-06-1981');

SELECT * FROM DEPARTAMENTO;

INSERT INTO FUNCIONARIO (Pnome, Minicial, Unome, Cpf, Datanasc, Endereco, Sexo, Salario, Cpf_supervisor, Dnr)
VALUES
('João', 'B', 'Silva', '12345678966', '09-01-1965', 'Rua das Flores, 751, São Paulo, SP', 'M', '30.000', 33344555587, 5),
('Fernando', 'T', 'Wong', '33344555587', '08-12-1955', 'Rua da Lapa, 34, São Paulo, SP', 'M', '40.000', 88866555576, 5),
('Alice', 'J', 'Zelaya', '99988777767', '19-01-1968', 'Rua Souza Lima, 35, Curitiba, PR', 'F', '25.000', 98765432168, 4),
('Jennifer', 'S', 'Souza', '98765432168', '20-06-1941', 'Av.Arthur de Lima, 54, SantoAndré, SP', 'F', '43.000', 88866555576, 4),
('Ronaldo', 'K', 'Lima', '66688444476', '15-09-1962', 'Rua Rebouças, 65, Piracicaba, SP', 'M', '38.000', 33344555587, 5),
('Joice', 'A', 'Leite', '45345345376', '31-07-1972', 'Av.Lucas Obes, 74, São Paulo, SP', 'F', '25.000', 33344555587, 5),
('André', 'V', 'Pereira', '98798798733', '29-03-1969', 'Rua Timbira, 35, São Paulo, SP', 'M' ,'25.000', 98765432168, 4),
('Jorge', 'E', 'Brito', '88866555576', '10-11-1937', 'Rua do Horto, 35, São Paulo, SP', 'M', '55.000', NULL, 1);

SELECT * FROM FUNCIONARIO;

INSERT INTO LOCALIZACAO_DEP (Dnumero, Dlocal)
VALUES
(1, 'São Paulo'),
(4, 'Mauá'),
(5, 'Santo André'),
(5, 'Itu'),
(5, 'SãoPaulo');

SELECT * FROM LOCALIZACAO_DEP;

INSERT INTO PROJETO (Projnome, Projnumero, Projlocal, Dnum)
VALUES
('ProdutoX', '1', 'Santo André', 5),
('ProdutoY', '2', 'Itu', 5),
('ProdutoZ', '3', 'São Paulo', 5),
('Informatização', '10', 'Mauá', 4),
('Reorganização', '20', 'São Paulo', 1),
('Novos beneficios', '30', 'Mauá', 4);

SELECT * FROM PROJETO;

INSERT INTO TRABALHA_EM (Fcpf, Pnr, Horas)
VALUES
(12345678966, 1, '32,5'),
(12345678966, 2, '7,5'),
(66688444476, 3, '40,0'),
(45345345376, 1, '20,0'),
(45345345376, 2, '20,0'),
(33344555587, 2, '10,0'),
(33344555587, 3, '10,0'),
(33344555587, 10, '10,0'),
(33344555587, 20, '10,0'),
(99988777767, 30, '30,0'),
(99988777767, 10, '10,0'),
(98798798733, 10, '35,0'),
(98798798733, 30, '5,0'),
(98765432168, 30, '20,0'),
(98765432168, 20, '15,0'),
(88866555576, 20, NULL);

SELECT * FROM TRABALHA_EM;

INSERT INTO DEPENDENTE (Fcpf, Nome_dependente, Sexo, Datanasc, Parentesco)
VALUES
(33344555587, 'Alicia', 'F', '05-04-1986', 'filha'),
(33344555587, 'Tiago', 'M', '25-10-1983', 'filho'),
(33344555587, 'Janaína', 'F', '03-05-1958', 'Esposa'),
(98765432168, 'Antonio', 'M', '28-02-1942', 'Marido'),
(12345678966, 'Michael', 'M', '04-01-1988', 'filho'),
(12345678966, 'Alicia', 'F', '30-12-1988', 'filha'),
(12345678966, 'Elizabeth', 'F', '05-05-1967', 'Esposa');

SELECT * FROM DEPENDENTE;