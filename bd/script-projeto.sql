/*
TABELAS

tabela usuario (idUsuario, nome da empresa, porte, cnpj, login, senha)
tabela produto (idProduto, nome, descricao, marca, volume)
tabela prateleira (idPrateleira, corredor, setor, obs, fk_produto)
tabela sensores (idSensor, bloqueio, status, fk_prateleira, fk_historico)
tabela histórico (idHistorico, dataHora)

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
	idProduto int primary key, 
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

create table sensor (
	idSensor int primary key auto_increment,
    idPrateleira int,
    sttSensor varchar(20),
    bloqueio tinyint,
    constraint chkSttSensor check (sttSensor in('Em funcionamento', 'Em manutenção', 'Desativado')),
    constraint chkBloqueio check (bloqueio in(0, 1)),
	constraint fk_prateleira foreign key (idPrateleira) references prateleira (idPrateleira)
);

create table historico(
	idHistorico int primary key auto_increment,
    idSensor int,
    dataHora datetime default current_timestamp,
	constraint fk_sensor foreign key (idSensor) references sensor (idSensor)
);


-- INSERTS 
-- tabela usuario (idUsuario, nome da empresa, porte, cnpj, email, senha)
insert into usuario (nomeEmpresa, porte, cnpj, email, senha) values
	('Atacadão', 'Grande', '75.315.333/0001-09', 'atacadao@outlook.com', 'senha123456*'),
    ('Mercado Km25', 'Médio', '21.558.222/0001-07', 'km25mercado@gmail.com', 'km25senha#'),
    ('Carrefour Express', 'Pequeno', '19.245.555/0001-15', 'carrefour@outlook.com', '12345678!');
    
-- tabela produto (idProduto, nome, descricao, marca, volume)
/*
idProduto int primary key, 
    nome varchar(80), 
    descricao text(700), 
    marca varchar(50),
    medida varchar(5),
    volume decimal(5, 2)
*/
insert into produto values 
	(0001, 'Desinfetante Multiuso', 'Produto de limpeza', 'Veja', 'L', '2.00');

-- tabela sensores (idSensor, bloqueio, status, fk_prateleira, fk_historico)




