select *from cliente;
insert into cliente (nome_completo,documento,apelido,data_nascimento,email,ativo) 
values ("yang cheng", '83355598333', "yang", '1959-10-06', "yang01cheng@email.com", 1);

select *from pedido;
insert into pedido (cliente_id,data,valor_total) values (10,'2020-10-16', 12890.89);
update pedido set data = '2020-04-22' where pedido_id = 9;

select *from nota_fiscal;
insert into nota_fiscal (pedido_id,valor_total) values (26, 792.78 );
delete from nota_fiscal where nota_fiscal_id in (48,49);

select *from entrega;
insert into entrega (prazo_entrega,endereco) values ('2020-12-26', "text");
update entrega set prazo_entrega = '2020-09-17' where entrega_id = 31;
delete from entrega where entrega_id = 2;

select *from produto;
insert into produto (nome,categoria,valor,fabricante) values ("fone de ouvido bluetooth", "tecnologia", 150.89, "dragon");
update produto set nome = "microondas" where produto_id = 13;

select *from pagamento;
insert into pagamento (pedido_id,confirmacao_pagamento,tipo_pagamento) values (36,1,"cartao credito");

select *from itens_pedido;
insert into itens_pedido (pedido_id,produto_id) values (31,15);
delete from itens_pedido where id = 42;

select *from transportadora;
insert into transportadora (nome,cnpj,ativo) values ("cargo", '21347000000132', 1);

select *from rotas_entregas;
insert into rotas_entregas (entrega_id,pedido_id,cliente_id,transportadora_id,rota) values (38,31,9,4,"SP05-085");

select *from itens_nota_fiscal;
insert into itens_nota_fiscal (produto_id,nota_fiscal_id,quantidade, descricao_produto,valor_unitario,valor_icms)
values (15,75,1,"colchao cama casal", 985.89, 1.00);
update itens_nota_fiscal set descricao_produto = "ferro de passar roupa" where id = 19;


-- exercicios

/* 4- No banco de dados do e-commerce: crie uma consulta que retorne todos os pedidos feitos no primeiro e no último dia de cada mês.*/

select max(dia) as maxima_data, min(dia) as min_data, mes from (
select YEAR(data) AS ano,
    MONTH(data) AS mes,
    DAYOFMONTH(data) AS dia,
    count(*) AS pedido_id
from pedido
group by ano,mes,dia
order by mes asc) datas_meses
group by mes; 


/* 5- No banco de dados do e-commerce: crie uma consulta que retorne os pedidos com valor total maior que 10.000 ordenados
 pelo valor total e pela data do pedido.*/
 
 select *from pedido where valor_total >= 10000.00
 order by valor_total,data;
 
/* 6- No banco de dados do e-commerce: crie uma consulta que retorne o ranking dos 3 produtos mais vendidos por mês de cada ano.*/

select count(produto_id) as qtd, produto_id, ano, mes from itens_pedido inner join (
select  ano, mes from (
select YEAR(data) AS ano,
    MONTH(data) AS mes
from pedido
group by ano,mes) datas_meses
group by ano,mes) pedidos_meses
group by ano,mes,produto_id
order by mes,ano, qtd desc; 


select count(produto_id) , produto_id
from itens_pedido
group by produto_id;

/* 7- No banco de dados do e-commerce: crie uma consulta que retorne os 5 nomes de clientes com o maior valor médio 
de pedidos realizados.*/

select pedido.valor_total as valor_pedido,
cliente.nome_completo as cliente
from pedido 
inner join cliente on pedido.cliente_id = cliente.cliente_id
order by pedido.valor_total desc limit 5;

select count(pedido.cliente_id) as qtd_pedidos,
cliente.nome_completo as cliente
from pedido 
inner join cliente on pedido.cliente_id = cliente.cliente_id
group by pedido.cliente_id
order by qtd_pedidos desc limit 5;