use master;
drop database banco_scratch;
create database banco_scratch;
use banco_scratch;


-- Tabelas --

create table tb_pessoas (
id_pessoa int NOT NULL identity (0,1),
nome varchar (50),
email varchar (100) unique,
sexo char(1),

primary key (id_pessoa),
)


create table tb_tarefa (
id_tarefa int NOT NULL identity (0,1),
titulo varchar (200) unique,
prazo_estimado date,
descricao varchar (200),
data_inicio date NOT NULL,
data_termino date, 

primary key (id_tarefa),
)

create table tb_metodologia (
id_metodologia int NOT NULL identity (0,1), 
metodo_nome varchar (50),

primary key (id_metodologia),
)

create table tarefa_participantes (
id_participante int NOT NULL primary key identity (0,1),
id_tarefa int NOT NULL,
id_pessoa int NOT NULL, 

foreign key (id_tarefa) references tb_tarefa (id_tarefa), 
foreign key (id_pessoa) references tb_pessoas(id_pessoa), 
)


-- insert tb_pessoas --

go 
insert into tb_pessoas ( nome, email, sexo)
values ('Paloma Rangel', 'palomara@gmail.com', 'f')
insert into tb_pessoas ( nome, email, sexo)
values ('Juliana Almeida', 'ju2010@hotmail.com', 'f')
insert into tb_pessoas ( nome, email, sexo)
values ('Marcos Santos', 'marcos_sp2017@outlook.com', 'm')
insert into tb_pessoas ( nome, email, sexo)
values ('Joel Oliveira', 'profjoel_tide@gmail.com', 'm')
insert into tb_pessoas ( nome, email, sexo)
values ('Eli Ernesto', 'ernestoeli@yahoo.com', 'm')
insert into tb_pessoas ( nome, email, sexo)
values ('Mariana Barros', 'mari_116@hotmail.com', 'f')

-- insert tb_tarefas --

go
insert into tb_tarefa (titulo, prazo_estimado,descricao, data_inicio, data_termino)
values ('Trabalho de Matematica', '2018-08-20', 'Resolver exercicios de calculo I', '2018-08-07', '2018-08-07')
insert into tb_tarefa (titulo, prazo_estimado,descricao, data_inicio, data_termino)
values ('Topico do TCC', '2018-08-08', 'Adicionar o indice de figuras', '2018-08-07', '2018-08-07')
insert into tb_tarefa (titulo, prazo_estimado,descricao, data_inicio, data_termino)
values ('Redação', '2018-08-18', 'Dissertacao argumentativa sobre a saude no Brasil','2018-08-04', '2018-08-05')
insert into tb_tarefa (titulo, prazo_estimado,descricao, data_inicio, data_termino)
values ('Calculadora em JAVA', '2018-08-09', 'Calculadora com soma, subtracao, multiplicacao e divisao', '2018-08-05', '2018-08-07')
insert into tb_tarefa (titulo, prazo_estimado,descricao, data_inicio, data_termino)
values ('Enviar documentos', '2018-08-08', 'Enviar documentos para isencao da taxa do vestibular', '2018-08-06', '2018-08-06')

-- insert tarefa_participantes --

go 
insert into tarefa_participantes (id_tarefa, id_pessoa)
values (0,1)

-- Consulta --

select * from tb_pessoas
select * from tb_tarefa
select * from tarefa_participantes

