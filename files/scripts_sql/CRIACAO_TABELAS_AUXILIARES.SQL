USE DWSUCOS;

DROP TABLE TEMP_AUXCONTROLE;
CREATE TABLE TEMP_AUXCONTROLE (
                                ID NVARCHAR(50) NULL,
								CONTADOR INT NULL,
								NIVEL int NULL,
								POS INT NOT NULL AUTO_INCREMENT,
								PRIMARY KEY (POS)
								);

DROP TABLE TEMP_AUXTABELA;
CREATE TABLE TEMP_AUXTABELA (
                                ID NVARCHAR(50) NULL,
								IDPAI NVARCHAR(50) NULL,
								ESQ int NULL,
								DIR int NULL,
								NIVEL int NULL,
								NOME CHAR(200) NULL
								);
								
								

INSERT INTO TEMP_AUXTABELA
	SELECT
		cod_organizacional as ID,
		cod_organizacional_superior as IDPAI,
		esquerda as ESQ,
		direita as DIR,
		nivel as NIVEL,
		desc_organizacional as NOME
		FROM Dim_Organizacional;