/*
TABELAS

tabela usuario (idUsuario, nome da empresa, porte, cnpj, login, senha)
tabela histórico (idHistorico, dataHora)
tabela prateleira (idPrateleira, corredor, setor, obs, fk_produto)
tabela sensores (idSensor, bloqueio, status, fk_prateleira, fk_historico)
tabela produto (idProduto, nome, descricao, marca, volume)
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

create table produto(
	idProduto int primary key auto_increment, 
    nome varchar(80), 
    descricao text(700), 
    marca varchar(50),
    medida varchar(5),
    volume decimal(5, 2),
	constraint chkMedida check(medida in ("kg", "L", "ml", "g"))
);

create table prateleira (
	idPrateleira int primary key auto_increment,
    idProduto int,
    corredor varchar(20),
    setor varchar(20),
    obs text(700),
    constraint fk_produto foreign key (idProduto) references produto(idProduto)
);

create table historico(
	idHistorico int primary key auto_increment,
    dataHora datetime default current_timestamp
);

create table sensor (
	idSensor int primary key auto_increment,
    idHistorico int,
    idPrateleira int,
    sttSensor varchar(20),
    bloqueio tinyint,
    constraint chkSttSensor check (sttSensor in('Em funcionamento', 'Em manutenção', 'Desativado')),
    constraint chkBloqueio check (bloqueio in(0, 1)),
    constraint fk_historico foreign key (idHistorico) references historico (idHistorico),
	constraint fk_prateleira foreign key (idPrateleira) references prateleira (idPrateleira)
);
