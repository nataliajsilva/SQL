create database ecommerceMentoriaSql;
use ecommerceMentoriaSql;

create table cliente (cliente_id smallint unsigned not null auto_increment,
nome_completo varchar(255) not null,
documento char(11) not null,
apelido varchar(50) not null,
data_nascimento date not null,
email varchar(255),
ativo bit not null,
primary key(cliente_id));

create table pedido (pedido_id smallint unsigned not null auto_increment,
cliente_id smallint unsigned not null,
data date not null,
valor_total float not null,
primary key(pedido_id),
foreign key(cliente_id) references cliente(cliente_id) on delete restrict);

create table nota_fiscal (nota_fiscal_id smallint unsigned not null auto_increment,
pedido_id smallint unsigned not null,
valor_total float not null,
primary key(nota_fiscal_id),
foreign key(pedido_id) references pedido(pedido_id) on delete restrict);

create table entrega (entrega_id smallint unsigned not null auto_increment,
prazo_entrega date not null,
endereco varchar(255) not null,
primary key(entrega_id));

create table produto (produto_id smallint unsigned not null auto_increment,
nome varchar(255) not null,
categoria varchar(100) not null,
valor float not null,
fabricante varchar(100) not null,
primary key(produto_id));

create table pagamento (id smallint unsigned not null auto_increment,
pedido_id smallint unsigned not null,
confirmacao_pagamento bit not null,
tipo_pagamento varchar(255) not null,
primary key(id),
foreign key(pedido_id) references pedido(pedido_id) on delete restrict);

create table itens_pedido (id smallint unsigned not null auto_increment,
pedido_id smallint unsigned not null,
produto_id smallint unsigned not null,
primary key(id),
foreign key(pedido_id) references pedido(pedido_id) on delete restrict,
foreign key(produto_id) references produto(produto_id) on delete restrict);

create table transportadora (transportadora_id smallint unsigned not null auto_increment,
nome varchar(255) not null,
cnpj char(14) not null,
ativo bit not null,
primary key(transportadora_id));

create table rotas_entregas (id smallint unsigned not null auto_increment,
entrega_id smallint unsigned not null,
pedido_id smallint unsigned not null,
cliente_id smallint unsigned not null,
transportadora_id smallint unsigned not null,
rota varchar(255) not null,
primary key(id),
key rota_entrega (entrega_id, pedido_id),
foreign key(pedido_id) references pedido(pedido_id) on delete restrict,
foreign key(entrega_id) references entrega(entrega_id) on delete restrict,
foreign key(cliente_id) references cliente(cliente_id) on delete restrict,
foreign key(transportadora_id) references transportadora(transportadora_id) on delete restrict);

create table itens_nota_fiscal (id smallint unsigned not null auto_increment,
produto_id smallint unsigned not null,
nota_fiscal_id smallint unsigned not null,
quantidade smallint unsigned not null,
descricao_produto varchar(255) not null,
valor_unitario float not null,
valor_icms float not null,
primary key(id),
foreign key(produto_id) references produto(produto_id) on delete restrict,
foreign key(nota_fiscal_id) references nota_fiscal(nota_fiscal_id) on delete restrict);


