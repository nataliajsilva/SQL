create database ecommerceMentoriaSql;
use ecommerceMentoriaSql;

create table cliente (cliente_id smallint unsigned not null auto_increment,
nome_completo varchar(255) not null,
documento char(11) not null,
apelido varchar(50) not null,
data_nascimento date not null,
email varchar(255),
ativo bit not null, -- melhor tipo bool
primary key(cliente_id));

alter table cliente MODIFY COLUMN ativo bool;

create table pedido (pedido_id smallint unsigned not null auto_increment,
cliente_id smallint unsigned not null,
data date not null, -- melhor tipo datetime
valor_total float not null,
primary key(pedido_id),
foreign key(cliente_id) references cliente(cliente_id) on delete restrict);

alter table pedido MODIFY COLUMN valor_total float unsigned not null;

create table nota_fiscal (nota_fiscal_id smallint unsigned not null auto_increment,
pedido_id smallint unsigned not null,
valor_total float not null,
primary key(nota_fiscal_id),
foreign key(pedido_id) references pedido(pedido_id) on delete restrict);

alter table nota_fiscal MODIFY COLUMN valor_total float unsigned not null;

create table entrega (entrega_id smallint unsigned not null auto_increment,
prazo_entrega date not null,
endereco varchar(255) not null,
primary key(entrega_id));

create table produto (produto_id smallint unsigned not null auto_increment,
nome varchar(255) not null,
categoria varchar(100) not null,
valor float not null,  -- unsigned
fabricante varchar(100) not null,
primary key(produto_id));

alter table produto MODIFY COLUMN valor float unsigned not null;

create table pagamento (id smallint unsigned not null auto_increment,
pedido_id smallint unsigned not null,
confirmacao_pagamento bit not null, -- melhor tipo bool
tipo_pagamento varchar(255) not null,
primary key(id),
foreign key(pedido_id) references pedido(pedido_id) on delete restrict);

alter table pagamento MODIFY COLUMN confirmacao_pagamento bool;

create table itens_pedido (id smallint unsigned not null auto_increment,
pedido_id smallint unsigned not null,
produto_id smallint unsigned not null,
primary key(id),
foreign key(pedido_id) references pedido(pedido_id) on delete restrict,
foreign key(produto_id) references produto(produto_id) on delete restrict);

create table transportadora (transportadora_id smallint unsigned not null auto_increment,
nome varchar(255) not null,
cnpj char(14) not null,
ativo bit not null, -- bool
primary key(transportadora_id));

alter table transportadora MODIFY COLUMN ativo bool;

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

alter table itens_nota_fiscal MODIFY COLUMN valor_unitario float unsigned not null;
alter table itens_nota_fiscal MODIFY COLUMN valor_icms float unsigned not null;