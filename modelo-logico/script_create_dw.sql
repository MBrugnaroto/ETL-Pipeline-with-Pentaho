USE DWSUCOS;

CREATE TABLE Dim_Organizacional (
                cod_organizacional NVARCHAR(50) NOT NULL,
                desc_organizacional NVARCHAR(250) NOT NULL,
                cod_organizacional_superior NVARCHAR(50) NOT NULL,
                esquerda INT NOT NULL,
                direita INT NOT NULL,
                nivel INT NOT NULL,
                PRIMARY KEY (cod_organizacional)
);

ALTER TABLE Dim_Organizacional COMMENT 'Tabela de dimensão Organizacional';


CREATE TABLE Dim_Categoria (
                cod_categoria NVARCHAR(50) NOT NULL,
                desc_categoria NVARCHAR(250) NOT NULL,
                PRIMARY KEY (cod_categoria)
);

ALTER TABLE Dim_Categoria COMMENT 'Tabela de dimensão Categoria';


CREATE TABLE Dim_Marc (
                cod_marca NVARCHAR(50) NOT NULL,
                cod_categoria NVARCHAR(50) NOT NULL,
                desc_marca NVARCHAR(250) NOT NULL,
                PRIMARY KEY (cod_marca)
);

ALTER TABLE Dim_Marc COMMENT 'Tabela de dimensão Marca';


CREATE TABLE Dim_Produto (
                cod_produto NVARCHAR(50) NOT NULL,
                cod_marca NVARCHAR(50) NOT NULL,
                desc_produto NVARCHAR(250) NOT NULL,
                atr_tamanho NVARCHAR(250) NOT NULL,
                atr_sabor NVARCHAR(250) NOT NULL,
                PRIMARY KEY (cod_produto)
);

ALTER TABLE Dim_Produto COMMENT 'Tabela de dimensão Produto';


CREATE TABLE Dim_Tempo (
                cod_tempo NVARCHAR(50) NOT NULL,
                Data DATE NOT NULL,
                numero_dia_semana NVARCHAR(50) NOT NULL,
                numero_mes NVARCHAR(50) NOT NULL,
                nome_mes NVARCHAR(250) NOT NULL,
                numero_ano NVARCHAR(50) NOT NULL,
                numero_trimestre NVARCHAR(50) NOT NULL,
                nome_trimestre NVARCHAR(250) NOT NULL,
                numero_semestre NVARCHAR(50) NOT NULL,
                nome_semestre NVARCHAR(250) NOT NULL,
                PRIMARY KEY (cod_tempo)
);

ALTER TABLE Dim_Tempo COMMENT 'Tabela da dimensão tempo';


CREATE TABLE Dim_Cliente (
                cod_cliente NVARCHAR(50) NOT NULL,
                desc_cliente NVARCHAR(250) NOT NULL,
                cod_cidade NVARCHAR(50) NOT NULL,
                desc_cidade NVARCHAR(250) NOT NULL,
                cod_estado NVARCHAR(50) NOT NULL,
                desc_estado NVARCHAR(250) NOT NULL,
                cod_regiao NVARCHAR(50) NOT NULL,
                desc_regiao NVARCHAR(250) NOT NULL,
                cod_segmento NVARCHAR(50) NOT NULL,
                desc_segmento NVARCHAR(250) NOT NULL,
                PRIMARY KEY (cod_cliente)
);

ALTER TABLE Dim_Cliente COMMENT 'Tabela da dimensão cliente';


CREATE TABLE fato_004 (
                cod_produto NVARCHAR(50) NOT NULL,
                cod_tempo NVARCHAR(50) NOT NULL,
                cod_organizacional NVARCHAR(50) NOT NULL,
                cod_cliente NVARCHAR(50) NOT NULL,
                meta_faturamento DOUBLE PRECISION NOT NULL,
                PRIMARY KEY (cod_produto, cod_tempo, cod_organizacional, cod_cliente)
);

ALTER TABLE fato_004 COMMENT 'Tabela de Fato 004';


CREATE TABLE Dim_Fabrica (
                cod_fabrica NVARCHAR(50) NOT NULL,
                desc_fabrica NVARCHAR(250) NOT NULL,
                PRIMARY KEY (cod_fabrica)
);

ALTER TABLE Dim_Fabrica COMMENT 'Tabela de dimensão Fábrica';


CREATE TABLE fato_005 (
                cod_produto NVARCHAR(50) NOT NULL,
                cod_tempo NVARCHAR(50) NOT NULL,
                cod_fabrica NVARCHAR(50) NOT NULL,
                meta_custo DOUBLE PRECISION NOT NULL,
                PRIMARY KEY (cod_produto, cod_tempo, cod_fabrica)
);

ALTER TABLE fato_005 COMMENT 'Tabela de Fato 005';


CREATE TABLE fato_003 (
                cod_fabrica NVARCHAR(50) NOT NULL,
                cod_tempo NVARCHAR(50) NOT NULL,
                custo_fixo DOUBLE PRECISION NOT NULL,
                PRIMARY KEY (cod_fabrica, cod_tempo)
);

ALTER TABLE fato_003 COMMENT 'Tabela de Fato 003';


CREATE TABLE fato_002 (
                cod_fabrica NVARCHAR(50) NOT NULL,
                cod_tempo NVARCHAR(50) NOT NULL,
                cod_cliente NVARCHAR(50) NOT NULL,
                cod_produto NVARCHAR(50) NOT NULL,
                custo_frete DOUBLE PRECISION NOT NULL,
                PRIMARY KEY (cod_fabrica, cod_tempo, cod_cliente, cod_produto)
);

ALTER TABLE fato_002 COMMENT 'Tabela de Fato 002';


CREATE TABLE Fato_001 (
                cod_frabrica NVARCHAR(50) NOT NULL,
                cod_tempo NVARCHAR(50) NOT NULL,
                cod_cliente NVARCHAR(50) NOT NULL,
                cod_organizacional NVARCHAR(50) NOT NULL,
                cod_produto NVARCHAR(50) NOT NULL,
                faturamento DOUBLE PRECISION NOT NULL,
                unidade_vendida DOUBLE PRECISION NOT NULL,
                quantidade_vendida DOUBLE PRECISION NOT NULL,
                imposto DOUBLE PRECISION NOT NULL,
                custo_variavel DOUBLE PRECISION NOT NULL,
                PRIMARY KEY (cod_frabrica, cod_tempo, cod_cliente, cod_organizacional, cod_produto)
);

ALTER TABLE Fato_001 COMMENT 'Tabela de Fato 001';


ALTER TABLE Fato_001 ADD CONSTRAINT dim_organizacional_fato_001_fk
FOREIGN KEY (cod_organizacional)
REFERENCES Dim_Organizacional (cod_organizacional)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fato_004 ADD CONSTRAINT dim_organizacional_fato_004_fk
FOREIGN KEY (cod_organizacional)
REFERENCES Dim_Organizacional (cod_organizacional)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Dim_Marc ADD CONSTRAINT dim_categoria_dim_marca_fk
FOREIGN KEY (cod_categoria)
REFERENCES Dim_Categoria (cod_categoria)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Dim_Produto ADD CONSTRAINT dim_marca_dim_produto_fk
FOREIGN KEY (cod_marca)
REFERENCES Dim_Marc (cod_marca)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Fato_001 ADD CONSTRAINT dim_produto_fato_001_fk
FOREIGN KEY (cod_produto)
REFERENCES Dim_Produto (cod_produto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fato_002 ADD CONSTRAINT dim_produto_fato_002_fk
FOREIGN KEY (cod_produto)
REFERENCES Dim_Produto (cod_produto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fato_004 ADD CONSTRAINT dim_produto_fato_004_fk
FOREIGN KEY (cod_produto)
REFERENCES Dim_Produto (cod_produto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fato_005 ADD CONSTRAINT dim_produto_fato_005_fk
FOREIGN KEY (cod_produto)
REFERENCES Dim_Produto (cod_produto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Fato_001 ADD CONSTRAINT dim_tempo_fato_001_fk
FOREIGN KEY (cod_tempo)
REFERENCES Dim_Tempo (cod_tempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fato_002 ADD CONSTRAINT dim_tempo_fato_002_fk
FOREIGN KEY (cod_tempo)
REFERENCES Dim_Tempo (cod_tempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fato_003 ADD CONSTRAINT dim_tempo_fato_003_fk
FOREIGN KEY (cod_tempo)
REFERENCES Dim_Tempo (cod_tempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fato_004 ADD CONSTRAINT dim_tempo_fato_004_fk
FOREIGN KEY (cod_tempo)
REFERENCES Dim_Tempo (cod_tempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fato_005 ADD CONSTRAINT dim_tempo_fato_005_fk
FOREIGN KEY (cod_tempo)
REFERENCES Dim_Tempo (cod_tempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Fato_001 ADD CONSTRAINT dim_cliente_fato_001_fk
FOREIGN KEY (cod_cliente)
REFERENCES Dim_Cliente (cod_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fato_002 ADD CONSTRAINT dim_cliente_fato_002_fk
FOREIGN KEY (cod_cliente)
REFERENCES Dim_Cliente (cod_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fato_004 ADD CONSTRAINT dim_cliente_fato_004_fk
FOREIGN KEY (cod_cliente)
REFERENCES Dim_Cliente (cod_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Fato_001 ADD CONSTRAINT dim_fabrica_fato_001_fk
FOREIGN KEY (cod_frabrica)
REFERENCES Dim_Fabrica (cod_fabrica)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fato_002 ADD CONSTRAINT dim_fabrica_fato_002_fk
FOREIGN KEY (cod_fabrica)
REFERENCES Dim_Fabrica (cod_fabrica)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fato_003 ADD CONSTRAINT dim_fabrica_fato_003_fk
FOREIGN KEY (cod_fabrica)
REFERENCES Dim_Fabrica (cod_fabrica)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fato_005 ADD CONSTRAINT dim_fabrica_fato_005_fk
FOREIGN KEY (cod_fabrica)
REFERENCES Dim_Fabrica (cod_fabrica)
ON DELETE NO ACTION
ON UPDATE NO ACTION;