
select * from fato_incremento;
select * from dim_pessoa_incremento;
select a.departamento, b.data, sum(b.valor) as valor 
from dim_pessoa_incremento a inner join fato_incremento b where a.id_pessoa = b.id_pessoa
group by a.departamento, b.data;

select * from fato;
select * from dim_pessoa;
select a.departamento, b.data, sum(b.valor) as valor 
from dim_pessoa a inner join fato b where a.id_pessoa = b.id_pessoa
group by a.departamento, b.data;

select * from fato_data;
select * from dim_pessoa_data;
select a.departamento, b.data, sum(b.valor) as valor 
from dim_pessoa_data a inner join fato_data b where a.id_pessoa = b.id_pessoa
group by a.departamento, b.data;