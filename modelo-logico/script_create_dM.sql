USE DMPRESIDENCIA;

CREATE TABLE Dim_Organizacional (
                id_vendedor INT NOT NULL,
                cod_vendedor NVARCHAR(50) NOT NULL,
                desc_vendedor NVARCHAR(250) NOT NULL,
                cod_gerente NVARCHAR(50) NOT NULL,
                desc_gerente NVARCHAR(250) NOT NULL,
                cod_diretor NVARCHAR(50) NOT NULL,
                desc_diretor NVARCHAR(250) NOT NULL,
                PRIMARY KEY (id_vendedor)
);

ALTER TABLE Dim_Organizacional COMMENT 'Tabela de dimensão Organizacional';


CREATE TABLE Dim_Produto (
                id_produto INT NOT NULL,
                cod_produto NVARCHAR(50) NOT NULL,
                cod_marca NVARCHAR(50) NOT NULL,
                desc_marca NVARCHAR(250) NOT NULL,
                cod_categoria NVARCHAR(50) NOT NULL,
                desc_categoria NVARCHAR(250) NOT NULL,
                desc_produto NVARCHAR(250) NOT NULL,
                atr_tamanho NVARCHAR(250) NOT NULL,
                atr_sabor NVARCHAR(250) NOT NULL,
                PRIMARY KEY (id_produto)
);

ALTER TABLE Dim_Produto COMMENT 'Tabela de dimensão Produto';


CREATE TABLE Dim_Cliente (
                id_cliente INT NOT NULL,
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
                PRIMARY KEY (id_cliente)
);

ALTER TABLE Dim_Cliente COMMENT 'Tabela da dimensão cliente';


CREATE TABLE Dim_Tempo (
                id_tempo INT NOT NULL,
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
                PRIMARY KEY (id_tempo)
);

ALTER TABLE Dim_Tempo COMMENT 'Tabela da dimensão tempo';


CREATE TABLE Dim_Fabrica (
                id_fabrica INT NOT NULL,
                cod_fabrica NVARCHAR(50) NOT NULL,
                desc_fabrica NVARCHAR(250) NOT NULL,
                PRIMARY KEY (id_fabrica)
);

ALTER TABLE Dim_Fabrica COMMENT 'Tabela de dimensão Fábrica';


CREATE TABLE fato_presidencia (
                id_produto INT NOT NULL,
                id_fabrica INT NOT NULL,
                id_cliente INT NOT NULL,
                id_vendedor INT NOT NULL,
                id_tempo INT NOT NULL,
                faturamento DOUBLE PRECISION NOT NULL,
                unidade_vendida DOUBLE PRECISION NOT NULL,
                quantidade_vendida DOUBLE PRECISION NOT NULL,
                imposto DOUBLE PRECISION NOT NULL,
                custo_variavel DOUBLE PRECISION NOT NULL,
                custo_frete DOUBLE PRECISION NOT NULL,
                meta_custo DOUBLE PRECISION NOT NULL,
                meta_faturamento DOUBLE PRECISION NOT NULL,
                custo_fixo DOUBLE PRECISION NOT NULL,
                PRIMARY KEY (id_produto, id_fabrica, id_cliente, id_vendedor, id_tempo)
);


ALTER TABLE fato_presidencia ADD CONSTRAINT organizacional_fato_presidencia_fk
FOREIGN KEY (id_vendedor)
REFERENCES Dim_Organizacional (id_vendedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fato_presidencia ADD CONSTRAINT produto_fato_presidencia_fk
FOREIGN KEY (id_produto)
REFERENCES Dim_Produto (id_produto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fato_presidencia ADD CONSTRAINT cliente_fato_presidencia_fk
FOREIGN KEY (id_cliente)
REFERENCES Dim_Cliente (id_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fato_presidencia ADD CONSTRAINT tempo_fato_presidencia_fk
FOREIGN KEY (id_tempo)
REFERENCES Dim_Tempo (id_tempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fato_presidencia ADD CONSTRAINT dim_fabrica_fato_presidencia_fk
FOREIGN KEY (id_fabrica)
REFERENCES Dim_Fabrica (id_fabrica)
ON DELETE NO ACTION
ON UPDATE NO ACTION;