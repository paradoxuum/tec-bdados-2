USE MASTER 
GO
DROP DATABASE Funcionarios
GO
CREATE DATABASE Funcionarios
GO
USE Funcionarios
GO

CREATE TABLE Departamento (
idDepart INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
nmDepart VARCHAR(100) UNIQUE
)
GO

CREATE TABLE Pessoa (
idPessoa INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
nmPessoa VARCHAR(100)
)
GO

CREATE TABLE RelPessoaDepart (
idRelacionamento INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
idDepart INT NOT NULL,
idPessoa INT NOT NULL
)
GO

ALTER TABLE RelPessoaDepart
ADD CONSTRAINT fk_idDepart FOREIGN KEY (idDepart) 
REFERENCES Departamento(idDepart)

ALTER TABLE RelPessoaDepart
ADD CONSTRAINT fk_idPessoa FOREIGN KEY (idPessoa) 
REFERENCES Pessoa(idPessoa)

INSERT INTO Departamento (nmDepart) VALUES ('Marketing'), ('Operacional'), ('Administrativo'), ('Consultoria'), ('RH')
GO

INSERT INTO Pessoa (nmPessoa) VALUES ('Júlio'), ('Eduardo'), ('Ricardo'), ('Ronaldo'), ('Fábio')
GO

INSERT INTO RelPessoaDepart (idDepart, idPessoa) VALUES (1, 1), (2, 2), (3, 3), (4, 4),(5, 5)
GO

IF OBJECT_ID ('trgAfterInsertPessoa') IS NOT NULL
DROP TRIGGER trgAfterInsertPessoa
GO

CREATE TRIGGER trgAfterInsertPessoa ON Departamento FOR INSERT AS 
DECLARE @IdDpto INT;
BEGIN
	DECLARE @idPessoa INT;
	SELECT @idPessoa = max(idPessoa) FROM Pessoa;
	
	IF NOT EXISTS(SELECT idPessoa FROM RelPessoaDepart WHERE idPessoa = @idPessoa)
	BEGIN
		DECLARE @NmDpto VARCHAR(180);
		DECLARE @auditAction VARCHAR(180);
		
		SELECT @IdDpto = i.idDepart FROM inserted i;
		
		SET @auditAction = 'Registro inserido';		
		
		INSERT INTO RelPessoaDepart (idDepart, idPessoa)
		VALUES (@IdDpto, @idPessoa);
	END;
	ELSE
	BEGIN
		ROLLBACK;
		SET @auditAction = 'Registro não inserido';
	END;
END
GO

BEGIN TRANSACTION
	INSERT INTO Pessoa (nmPessoa) VALUES ('Chico')
	GO
	INSERT INTO Departamento (nmDepart) VALUES ('Financeiro')
COMMIT
GO

SELECT 
	p.idPessoa 'Código do Funcionário', 
	p.nmPessoa 'Nome do Funcionário', 
	d.nmDepart 'Departamento do Funcionário'
FROM Pessoa AS p 
INNER JOIN RelPessoaDepart AS rel ON p.idPessoa = rel.idPessoa 
INNER JOIN Departamento AS d ON d.idDepart = rel.idDepart


--SELECT * FROM RelPessoaDepart
--SELECT * FROM Departamento ORDER BY idDepart