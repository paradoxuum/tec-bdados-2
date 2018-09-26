use master
go
drop database banco0708
go
create database banco0708
go
use banco0708
go

create table metodologia (
id int primary key identity (1,1),
titulo varchar(100)
)

create table tarefa (
id int primary key NOT NULL identity (1,1),
titulo varchar(100) not null,
prazo_estimado date,
descricao varchar(250),
data_inicio date not null,
data_termino date,
id_metodologia int,
foreign key (id_metodologia) references metodologia (id)
)

create table pessoas (
id int primary key NOT NULL identity (1,1),
nome varchar(100),
email varchar(100),
sexo varchar(20)
)


create table rel_tarefa_pessoa (
id int primary key NOT NULL identity (1,1),
id_tarefa int,
id_pessoas int


foreign key (id_pessoas) references pessoas (id),
foreign key (id_tarefa) references tarefa (id)

)


insert into metodologia values('Pomodoro')
insert into metodologia values('Design Thinking')
insert into metodologia values('OKRs')
insert into metodologia values('Scrum')
insert into metodologia values('')

insert into pessoas (nome, email, sexo) values('Eduardo','eduardo@email.com','m')
insert into pessoas (nome, email, sexo) values('Fábio','fabio@email.com','m')
insert into pessoas (nome, email, sexo) values('Caroline','carol@email.com','f')
insert into pessoas (nome, email, sexo) values('Geraldo','geraldo@email.com','m')
insert into pessoas (nome, email, sexo) values('Carlos','carlos@email.com','m')
insert into pessoas (nome, email, sexo) values('Jessica','jessica@email.com','f')

insert into tarefa (titulo,prazo_estimado, descricao,data_inicio,data_termino,id_metodologia ) 
values ('Primeira Etapa Sync','2018-08-25','Levantamento de Requisitos','2018-08-08','2018-08-30',1)

insert into tarefa (titulo,prazo_estimado, descricao,data_inicio,data_termino, id_metodologia) 
values('Novo Produto Partners','2018-08-10','Partners','2018-08-08','2018-08-10', 2)

insert into tarefa (titulo,prazo_estimado, descricao,data_inicio,data_termino, id_metodologia) 
values('Novo Produto Last Piece','2018-08-25','Last Piece','2018-08-08','2018-08-20', 2)

insert into tarefa  (titulo,prazo_estimado, descricao,data_inicio,data_termino, id_metodologia)
values('Quarta Etapa Sync','2018-06-12','Bancos de Dados','2018-08-08','2018-08-20', 3)

insert into tarefa  (titulo,prazo_estimado, descricao,data_inicio,data_termino, id_metodologia)
values('Estudos','2018-02-26','Estudo avançado de React Native','2018-08-08','2018-08-20', 2)

insert into tarefa  (titulo,prazo_estimado, descricao,data_inicio,data_termino, id_metodologia)
values('Finalizar Video Doze Coisas','2018-07-27','Inserir audio e efeitos sonoros','2018-08-08','2018-08-20', 2)

insert into tarefa  (titulo,prazo_estimado, descricao,data_inicio,data_termino, id_metodologia)
values('Finalizar Video Doze Coisas','2018-07-28','Fazer calculadora em Java','2018-08-08','2018-08-30', 2)

insert into rel_tarefa_pessoa (id_tarefa, id_pessoas) values (1,1)
insert into rel_tarefa_pessoa (id_tarefa, id_pessoas) values (2,2)
insert into rel_tarefa_pessoa (id_tarefa, id_pessoas) values (3,1)
insert into rel_tarefa_pessoa (id_tarefa, id_pessoas) values (4,4)
insert into rel_tarefa_pessoa (id_tarefa, id_pessoas) values (5,5)
insert into rel_tarefa_pessoa (id_tarefa, id_pessoas) values (6,1)
insert into rel_tarefa_pessoa (id_tarefa, id_pessoas) values (7,6)

--Exercicio 1

select p.nome as 'Pessoas Sem Tarefas' from pessoas as p 
left join rel_tarefa_pessoa as r on p.id = r.id_pessoas where r.id_tarefa is null

-- Exercicio 2

select m.titulo as Metodologia, count (m.titulo) as 'Vezes Utilizadas' 
from metodologia as m inner join tarefa as t
on (m.id = t.id_metodologia)
group by m.titulo 
order by count(m.titulo) desc;

-- Exercicio 3

--Homens
select p.nome as 'Homens com Tarefas', count (p.sexo) as 'Número de Tarefas' from rel_tarefa_pessoa as t 
left join pessoas as p on t.id_pessoas = p.id where p.sexo = 'm' group by p.nome

--Mulheres 
select p.nome as 'Mulheres com Tarefas', count (p.sexo) as 'Número de Tarefas' from rel_tarefa_pessoa as t 
left join pessoas as p on t.id_pessoas = p.id where p.sexo = 'f' group by p.nome

-- Exercicio 4
select p.nome as Nome, p.id as 'ID Pessoa', t.id as 'ID Tarefa', t.prazo_estimado as Prazo, t.data_termino as 'Data de Conclusão'
from tarefa as t
inner join rel_tarefa_pessoa as tp on t.id = tp.id_tarefa
inner join pessoas as p on p.id = tp.id_pessoas
where t.data_termino > t.prazo_estimado
 
if OBJECT_ID ('trocaPrazo') is not null
	drop procedure trocaPrazo;
	go

create procedure trocaPrazo as
begin
	update tarefa set prazo_estimado='2018-08-30' where id_metodologia = 2;
end
go

exec trocaPrazo

select titulo as Titulo, id_metodologia as Metodologia, prazo_estimado as Prazo from tarefa where id_metodologia = 2;