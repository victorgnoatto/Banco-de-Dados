--Use SQL DDL para criar um esquema de banco de dados relacional baseado no modelo relacional da figura a seguir.
--Salvar como item01.sql. Este esquema abaixo foi retirado do livro que estamos utilizando como referÍncia.
CREATE TABLE FUNCIONARIO(
	Pnome VARCHAR(20) NOT NULL,
	Minicial VARCHAR(1),
	Unome VARCHAR(20) NOT NULL,
	Cpf VARCHAR(11) PRIMARY KEY NOT NULL,
	Datanasc DATE not null check(Datanasc < getdate()),
	Endereco VARCHAR(50),
	Sexo VARCHAR(1),
	Salario DECIMAL(10,3),
	Cpf_supervisor VARCHAR(11),
	Dnr INT);

ALTER TABLE FUNCIONARIO ADD CONSTRAINT FK1FUNCIONARIO FOREIGN KEY(Cpf_supervisor)
REFERENCES FUNCIONARIO (Cpf);

ALTER TABLE FUNCIONARIO ADD CONSTRAINT FK2FUNCIONARIO FOREIGN KEY(Dnr)
REFERENCES DEPARTAMENTO (Dnumero);

CREATE TABLE DEPARTAMENTO(
	Dnome VARCHAR(50) NOT NULL,
	Dnumero INT PRIMARY KEY NOT NULL,
	Cpf_gerente VARCHAR(11),
	Data_inicio_gerente DATE);

ALTER TABLE DEPARTAMENTO ADD CONSTRAINT FK1DEPARTAMENTO FOREIGN KEY(Cpf_gerente)
REFERENCES FUNCIONARIO (CPF);

CREATE TABLE LOCALIZACAO_DEP(
	Dnumero INT,
	Dlocal VARCHAR(30) PRIMARY KEY NOT NULL
	);

ALTER TABLE LOCALIZACAO_DEP ADD CONSTRAINT FK1LOCALIZACAO_DEP FOREIGN KEY(Dnumero)
REFERENCES DEPARTAMENTO (Dnumero);

CREATE TABLE TRABALHA_EM(
	Fcpf VARCHAR(11),
	Pnr INT,
	Horas VARCHAR(10)
	);

ALTER TABLE TRABALHA_EM ADD CONSTRAINT FK1TRABALHA_EM FOREIGN KEY(Fcpf)
REFERENCES FUNCIONARIO (Cpf);

ALTER TABLE TRABALHA_EM ADD CONSTRAINT FK4TRABALHA_EM FOREIGN KEY(Pnr)
REFERENCES PROJETO(Projnumero);



CREATE TABLE PROJETO(
	Projnome VARCHAR(30),
	Projnumero INT PRIMARY KEY NOT NULL,
	Projlocal VARCHAR(30),
	Dnum INT
	);


ALTER TABLE PROJETO ADD CONSTRAINT FK1PROJETO FOREIGN KEY(Dnum)
REFERENCES DEPARTAMENTO (Dnumero);

CREATE TABLE DEPENDENTE(
	Fcpf VARCHAR(11),
	Nome_dependente VARCHAR(20) PRIMARY KEY NOT NULL,
	Sexo VARCHAR(1),
	Datanasc DATE not null check(Datanasc < getdate()),
	Parentesco VARCHAR(20)
	);

ALTER TABLE DEPENDENTE ADD CONSTRAINT FK1DEPENDENTE FOREIGN KEY(Fcpf)
REFERENCES FUNCIONARIO (Cpf);
