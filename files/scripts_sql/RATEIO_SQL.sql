USE DWSUCOS;
SELECT X.Cod_Cliente
      ,X.Cod_Produto
      ,X.Cod_Organizacional
      ,X.Cod_Fabrica
      ,X.Cod_Tempo
      ,X.Faturamento
      ,X.Imposto
      ,X.Custo_Variavel
	  ,X.Unidade_Vendida
      ,X.Quantidade_Vendida
	  ,(X.Quantidade_Vendida/Y.Quantdade_Vendida_002) * Y.Custo_Frete AS Frete_Rateio
	  ,(X.Quantidade_Vendida/W.Quantdade_Vendida_003) * W.Custo_Fixo AS Custo_Fixo_Rateio
	  ,(X.Quantidade_Vendida/Z.Quantdade_Vendida_004) * Z.Meta_Faturamento AS Meta_Faturamento_Rateio
	  ,(X.Quantidade_Vendida/K.Quantdade_Vendida_005) * K.Meta_Custo AS Meta_Custo_Rateio
  FROM fato_001 X
  INNER JOIN (
SELECT A.Cod_Cliente
      ,A.Cod_Produto
      ,A.Cod_Fabrica
      ,A.Cod_Tempo
      ,A.Custo_Frete
	  , B.Quantdade_Vendida_002
  FROM Fato_002 A
  INNER JOIN (
SELECT Cod_Cliente
      ,Cod_Produto
      ,Cod_Fabrica
      ,Cod_Tempo
      ,SUM(Quantidade_Vendida) AS Quantdade_Vendida_002
  FROM Fato_001
  GROUP BY Cod_Cliente
      ,Cod_Produto
      ,Cod_Fabrica
      ,Cod_Tempo) B
	  ON A.Cod_Cliente = B.Cod_Cliente AND A.Cod_Produto = B.Cod_Produto
	  AND A.Cod_Fabrica = B.Cod_Fabrica AND A.Cod_Tempo = B.Cod_Tempo ) Y
	  ON X.Cod_Cliente = Y.Cod_Cliente AND X.Cod_Produto = Y.Cod_Produto
	  AND X.Cod_Fabrica = Y.Cod_Fabrica AND X.Cod_Tempo = Y.Cod_Tempo
INNER JOIN (
  SELECT A.Cod_Fabrica
      ,A.Cod_Tempo
      ,A.Custo_Fixo
	  , B.Quantdade_Vendida_003
  FROM Fato_003 A
  INNER JOIN (
   SELECT Cod_Fabrica
      ,Cod_Tempo
      ,SUM(Quantidade_Vendida) AS Quantdade_Vendida_003
  FROM Fato_001
  GROUP BY Cod_Fabrica
      ,Cod_Tempo) B
	  ON A.Cod_Fabrica = B.Cod_Fabrica AND A.Cod_Tempo = B.Cod_Tempo ) W
	  ON X.Cod_Fabrica = W.Cod_Fabrica AND X.Cod_Tempo = W.Cod_Tempo
inner join (
	  SELECT A.Cod_Cliente
      ,A.Cod_Produto
      ,A.Cod_Organizacional
      ,A.Cod_Tempo
      ,A.Meta_Faturamento
	  ,B.Quantdade_Vendida_004
  FROM Fato_004 A
  INNER JOIN (
  	  SELECT Cod_Cliente
      ,Cod_Produto
      ,Cod_Organizacional
      ,Cod_Tempo
      ,SUM(Quantidade_Vendida) AS Quantdade_Vendida_004
  FROM Fato_001
  GROUP BY Cod_Cliente
      ,Cod_Produto
      ,Cod_Organizacional
      ,Cod_Tempo) B ON 
   A.Cod_Cliente = B.Cod_Cliente AND A.Cod_Produto = B.Cod_Produto
	  AND A.Cod_Tempo = B.Cod_Tempo ) Z
	  ON X.Cod_Cliente = Z.Cod_Cliente AND X.Cod_Produto = Z.Cod_Produto
	  AND X.Cod_Tempo = Z.Cod_Tempo
INNER JOIN (
	  SELECT A.Cod_Produto
      ,A.Cod_Fabrica
      ,A.Cod_Tempo
      ,A.Meta_Custo
	  ,B.Quantdade_Vendida_005
  FROM Fato_005 A
  INNER JOIN (
	  SELECT Cod_Produto
      ,Cod_Fabrica
      ,Cod_Tempo
      ,SUM(Quantidade_Vendida) AS Quantdade_Vendida_005
  FROM Fato_001
  GROUP BY Cod_Produto
      ,Cod_Fabrica
      ,Cod_Tempo) B
	  ON 	A.Cod_Produto = B.Cod_Produto
	  AND A.Cod_Fabrica = B.Cod_Fabrica AND A.Cod_Tempo = B.Cod_Tempo ) K
ON X.Cod_Produto = K.Cod_Produto
	  AND X.Cod_Fabrica = K.Cod_Fabrica AND X.Cod_Tempo = K.Cod_Tempo
	  WHERE CAST(SUBSTRING(X.Cod_tempo,1,4) AS UNSIGNED) >= 2013 
	  AND CAST(SUBSTRING(X.Cod_tempo,5,2) AS UNSIGNED) >= 1
	  AND CAST(SUBSTRING(X.Cod_tempo,1,4) AS UNSIGNED) <= 2013 
	  AND CAST(SUBSTRING(X.Cod_tempo,5,2) AS UNSIGNED) <= 1;