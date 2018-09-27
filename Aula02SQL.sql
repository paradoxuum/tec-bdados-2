use master
go
drop database Lojinha
go
create database Lojinha
go
use Lojinha
go
create table tb_clientes (
	id_cliente int NOT NULL PRIMARY KEY IDENTITY (1,1), 
	nome nvarchar(100), 
	endereco nvarchar(500),
	fone nvarchar (30),
	email nvarchar (255)
	)
go
create table tb_hardware (
	id_hardware int NOT NULL PRIMARY KEY IDENTITY (1,1),
	descricao nvarchar(500),
	preco money,
	qtde int,
	qtde_min int
	)
go
create table tb_vendas(
	id_venda int NOT NULL PRIMARY KEY IDENTITY (1,1),
	id_cliente int, --FK
	data date,
	vlrtotal money,
	desconto float,
	vlrpago money
	)
go
create table tb_vendas_itens(
	id_item int NOT NULL PRIMARY KEY IDENTITY (1,1),
	id_venda int, --FK
	id_hardware int, --FK
	total_item money
	)
go

alter table tb_vendas 
	add constraint fk_tb_clientes 
	foreign key (id_cliente) 
	references tb_clientes (id_cliente)
go
alter table tb_vendas_itens 
	add constraint fk_tb_hardware 
	foreign key (id_hardware) 
	references tb_hardware (id_hardware)
go
alter table tb_vendas_itens 
	add constraint fk_tb_venda 
	foreign key (id_venda) 
	references tb_vendas (id_venda)
go

insert into tb_clientes (nome, endereco, fone, email) values ('Edcleison', 'Rua da Silva, 42', 1170707070, 'edcleison@bol.com.br');
insert into tb_clientes (nome, endereco, fone, email) values ('Jocefaldo', 'Rua de Souza, 43', 1170707071, 'jocefaldo@terra.com.br');
insert into tb_clientes (nome, endereco, fone, email) values ('Adebaior', 'Rua de Santos, 44', 1170707072, 'adebaior@uol.com.br');
insert into tb_clientes (nome, endereco, fone, email) values ('Izuanilson', 'Rua de Lima, 45', 1170707073, 'izuanilson@ig.com.br');
insert into tb_clientes (nome, endereco, fone, email) values ('Kleberdilson', 'Rua Lopes, 46', 1170707074, 'kleberdilson@yahoo.com.br');

insert into tb_hardware(descricao, preco, qtde, qtde_min) values ('Placa de Video VGA NVIDIA ASUS GEFORCE GTX 1080 TI GDDR5X 11GB ROG-STRIX-GTX1080TI-O11G-GAMING', 4880.79, 40, 10);
insert into tb_hardware(descricao, preco, qtde, qtde_min) values ('Processador AMD Ryzen Threadripper 1950X, Hexadeca-Core, Cache 40MB, 3.4GHz (4GHz Max Turbo)', 4439.90, 16, 4);
insert into tb_hardware(descricao, preco, qtde, qtde_min) values ('Memória Kingston HyperX FURY 8GB 2133Mhz DDR4 CL14 Black', 499.90, 253, 25);
insert into tb_hardware(descricao, preco, qtde, qtde_min) values ('SSD Kingston 2.5´ 480GB A400 SATA III Leituras: 500MBs / Gravações: 450MBs - SA400S37/480G', 749.90, 49, 5);
insert into tb_hardware(descricao, preco, qtde, qtde_min) values ('HD Seagate Externo Portátil Expansion USB 3.0 1TB Preto - STEA1000400', 269.90, 100, 11);

select nome,fone from tb_clientes;

