/*
TABELAS

tabela usuario (id, nome da empresa, cnpj, login, senha)
tabela sensores (id, status)
tabela prateleira (id, descricao, seção)

inventory imperium
inventorium
Help-stock

*/

create database db_helpstock;
use db_helpstock;

-- TABELAS
create table usuario (
	idUsuario int primary key auto_increment,
    nomeEmpresa varchar(100),
    cnpj varchar(20),
    email varchar(100),
    senha varchar(50)
);

create table sensor (
	idSensor int primary key auto_increment,
    sttSensor varchar(20),
    bloqueio tinyint,
    constraint chkSttSensor check (sttSensor in('Em funcionamento', 'Em manutenção', 'Desativado'))
);

create table prateleira (
	idPrateleira int primary key auto_increment,
    secao varchar(20),
    descricao varchar(100)
);

-- INSERÇÃO DE DADOS


-- CONSULTAS