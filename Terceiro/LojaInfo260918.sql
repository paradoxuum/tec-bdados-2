use master
go
drop database	lojainfo
go
create database lojainfo
go
use lojainfo


create table tb_cliente (
	id_cliente	int primary key identity (1,1)NOT NULL,
	nome		nvarchar (60),
	endr�		nvarchar (100),
	fone		nvarchar (20),
	email		nvarchar (60))

create table tb_hardware (
	id_hardware	int primary key identity (1,1) NOT NULL,
	descricao	nvarchar (150),
	pre�o		decimal,
	qtde		int,
	qtdemin		int,
	
	foreign key (id_hardware) references tb_hardware (id_hardware)
	
	)

create table tb_vendas (
	id_venda	int primary key identity (1,1)NOT NULL,
	id_cliente	int, 
	data		date,
	vlrtotal	decimal,
	desconto	decimal,
	vlrpago		decimal,
	
	foreign key (id_cliente)references tb_cliente (id_cliente) 
	
	)

create table vendas_itens (
	id_item		int primary key identity (1,1)NOT NULL,
	id_venda	int, 
	id_hardware int,
	qtde_item	int,
	total_item	int,
	
	foreign key (id_venda)references tb_vendas (id_venda), 
	foreign key (id_hardware) references tb_hardware (id_hardware)
	
	)

insert into tb_cliente (nome, endr�, fone, email)
values 
('Huguinho', 'Rua das Flores','2620-2959','hugo.rodrigues@outlook.com'),
('Marcelo', 'Rua Esquerda', '2525-2525', 'marcelo2010@email.com'),
('Paloma', 'Rua Laranja', '2020-2020', 'palomara@email.com'),
('Henrique', 'Sabado Dangelo', '2489-7634', 'hank@email.com')

insert into tb_hardware (descricao, pre�o, qtde, qtdemin)
values
('Mouse HP', '48.00', '130', '100'),
('Fone Samsung', '35.00' ,'180' ,'150'),
('Computador DELL', '3600.00', '100', '70'),
('Arduino MEGA', '30.00', '200', '150')

insert into tb_vendas (id_cliente, data, vlrtotal, desconto, vlrpago)
values 
(4, '2018-08-19', '83.00' ,'10.00', '73.00'),
(3, '2018-09-01', '3600.00', '200.00', '3400.00')

insert into vendas_itens (id_venda, id_hardware, qtde_item, total_item)
values
(1, 2, 1, 1),
(1, 1, 1, 1) 


--select (id_cliente) as 'ID Cliente', (nome) as 'Nome', (endr�) as 'Endere�o', (fone) as 'Telefone', (email) as 'E-mail' from tb_cliente 
--select (id_hardware) as 'ID Hardware', (descricao) as 'Descri��o', (pre�o) as 'Pre�o', (qtde) as 'Qtd', (qtdemin) as 'Qtd M�n' from tb_hardware
--select (id_venda) as 'ID Venda', (id_cliente) as 'ID Cliente', (data) as 'Data', (vlrtotal) as 'Vlr Total', (desconto) as 'Desconto', (vlrpago) as 'Vlr Pago' from tb_vendas
--select (id_venda) as 'ID Venda', (id_hardware) as 'ID Hardware', (qtde_item) as 'Qtd Item', (total_item) as 'Total item' from vendas_itens


go

select*from tb_hardware

IF OBJECT_ID ('acrescimo10') is not null
	drop procedure acrescimo10;
	go
create procedure acrescimo10 as
begin
	update tb_hardware set pre�o=pre�o+(pre�o*0.10);
end
go
exec acrescimo10;