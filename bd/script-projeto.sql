/*
TABELAS

tabela usuario (id, nome da empresa, porte, cnpj, login, senha)
tabela sensores (id, status)
tabela prateleira (id, descricao, seção)

*/

create database db_helpstock;
use db_helpstock;

-- TABELAS
create table usuario (
	idUsuario int primary key auto_increment,
    nomeEmpresa varchar(100),
    porte varchar(20),
    cnpj varchar(20),
    email varchar(100),
    senha varchar(50),
    constraint chkPorte check (porte in('Pequeno', 'Médio', 'Grande'))
);

create table sensor (
	idSensor int primary key auto_increment,
    sttSensor varchar(20),
    bloqueio tinyint,
    constraint chkSttSensor check (sttSensor in('Em funcionamento', 'Em manutenção', 'Desativado')),
    constraint chkBloqueio check (bloqueio in(0, 1))
);

create table prateleira (
	idPrateleira int primary key auto_increment,
    corredor varchar(20),
    secao varchar(20),
    descricao varchar(100)
);

create table historico(
	idHistorico int primary key auto_increment,
    dataHora datetime default current_timestamp
);

-- INSERÇÃO DE DADOS
insert into usuario (nomeEmpresa, cnpj, email, senha) values 
	('Atacadão', '11.333.444/0001-22', 'atacadao@gmail.com', '12345678'),
    ('Extra', '88.111.999/0001-55', 'extra@hotmail.com', '0987654321');

insert into sensor( sttSensor, bloqueio) values 
	('Em funcionamento', 1),
    ('Em manutenção', 0);
    
INSERT INTO prateleira (secao, descricao, corredor) VALUES
	('Produtos de Limpeza', 'Amaciante OMO', '4'),
    ('Bebidas', 'Coca-cola', 'A');
    
INSERT INTO historico (idHistorico) VALUES 
	(NULL),
    (NULL);
    

-- CONSULTAS    
SELECT * FROM sensor;
SELECT * FROM usuario;
SELECT * FROM prateleira;
SELECT * FROM historico;
