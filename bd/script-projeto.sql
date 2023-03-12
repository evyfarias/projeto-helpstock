/*
TABELAS

tabela usuario (idUsuario, nome da empresa, porte, cnpj, login, senha)
tabela produto (idProduto, nome, descricao, marca, volume)
tabela prateleira (idPrateleira, corredor, setor, obs, fk_produto)
tabela sensores (idSensor, status, fk_prateleira, )
tabela histórico (idHistorico, dataHora, bloqueio, fk_sensor)

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
    flxCaixa int, 
	constraint chkMedida check(medida in ("kg", "L", "ml", "g"))
);

create table prateleira (
	idPrateleira int primary key auto_increment,
    idProduto int,
    corredor varchar(20),
    nivel varchar(20),
    setor varchar(20),
    obs text(700),
    volumePrateleira int,
    constraint chkNivel check(nivel in ("Cheia", "Vazia", "Esvaziando")),
    constraint fk_produto foreign key (idProduto) references produto(idProduto)
);

create table sensor (
	idSensor int primary key auto_increment,
    idPrateleira int,
    sttSensor varchar(20),
    constraint chkSttSensor check (sttSensor in('Em funcionamento', 'Em manutenção', 'Desativado')),
	constraint fk_prateleira foreign key (idPrateleira) references prateleira (idPrateleira)
);

create table historico(
	idHistorico int primary key auto_increment,
    idSensor int,
    bloqueio tinyint,
    dataHora datetime default current_timestamp,
    constraint chkBloqueio check (bloqueio in(0, 1)),
	constraint fk_sensor foreign key (idSensor) references sensor (idSensor)
);

-- INSERTS 
-- tabela usuario (idUsuario, nome da empresa, porte, cnpj, email, senha)
insert into usuario (nomeEmpresa, porte, cnpj, email, senha) values
	('Atacadão', 'Grande', '75.315.333/0001-09', 'atacadao@outlook.com', 'senha123456*'),
    ('Mercado Km25', 'Médio', '21.558.222/0001-07', 'km25mercado@gmail.com', 'km25senha#'),
    ('Carrefour Express', 'Pequeno', '19.245.555/0001-15', 'carrefour@outlook.com', '12345678!');
    
insert into produto values 
	(0001, 'Desinfetante Multiuso', 'Higiene e limpeza', 'Veja', 'ml', '500', 100),
    (0023, 'Refrigerante guaraná', 'Adega e bebidas', 'Veja', 'L', '2.00', 200),
    (0120, 'Bolacha Recheada Passatempo', 'Cereais', 'Nestle', 'g', '2.00', 400),
    (0009, 'Refri. Coca Cola', 'Adega e bebidas', 'Coca Cola', 'L', '2.00', 50),
    (0442, 'Arroz', 'Alimentos', 'Camil', 'Kg', '5.00', 30),
    (0050, 'Feijão', 'Alimentos', 'Camil', 'Kg', '2.00', 40);

insert into prateleira (idProduto, corredor, nivel, setor, obs, volumePrateleira) values
	(0023, '09', 'Cheia',  'Bebidas', 'O produto se localiza no centro da prateleiera', 100),
    (0001, '02', 'Esvaziando','Higiene Limpeza', 'O produto se localiza no início da prateleiera', 50),
    (0009, '09', 'Vazia', 'Bebidas', 'O produto se localiza nas prateleiras de cima', 0),
    (0050, '04', 'Cheia', 'Alimentos', 'Presente nas prateleiras de baixo', 60),
    (0120, '07', 'Vazia', 'Cereais', 'Se encontra de frente para os produtos x', 0),
    (0442, '04', 'Esvaziando', 'Alimentos', 'Entre os produtos X e Y', 30);

insert into sensor (idPrateleira, sttSensor) values
	(1, 'Em funcionamento'),
    (1, 'Em funcionamento'),
    (1, 'Em funcionamento'),
    (2, 'Em funcionamento'),
    (2, 'Em funcionamento'),
    (2, 'Em funcionamento'),
	(3, 'Em funcionamento'),
    (3, 'Em funcionamento'),
    (3, 'Em funcionamento'),
	(4, 'Em funcionamento'),
    (4, 'Em funcionamento'),
    (4, 'Em funcionamento'),
    (5, 'Em funcionamento'),
    (5, 'Em funcionamento'),
    (5, 'Em funcionamento'),
    (6, 'Em funcionamento'),
    (6, 'Em funcionamento'),
    (6, 'Em funcionamento');

insert into historico (idSensor, dataHora, bloqueio) values
	(1, DEFAULT, 1),
    (2, DEFAULT, 1),
    (3, DEFAULT, 1),
    
    (4, DEFAULT, 1),
    (5, DEFAULT, 0),
    (6, DEFAULT, 0),
    
	(7, DEFAULT, 0),
    (8, DEFAULT, 0),
    (9, DEFAULT, 0),
    
    (10, DEFAULT, 1),
    (11, DEFAULT, 1),
    (12, DEFAULT, 1),
    
    (13, DEFAULT, 0),
    (14, DEFAULT, 0),
    (15, DEFAULT, 0),
    
    (16, DEFAULT, 1),
    (17, DEFAULT, 0),
    (18, DEFAULT, 0);
    
  -- MOSTRAR PRATELEIRAS E SEUS PRODUTOS
SELECT idPrateleira, idProduto FROM prateleira; 

 -- MOSTRAR INFORMAÇÕES DO PRODUTO QUE ESTÁ VINCULADO A PRATELEIRA id = 2
 SELECT * FROM produto WHERE idProduto = 1;
 
-- NIVÉL DA PRATELEIRA ID = 2
SELECT nivel FROM prateleira WHERE idPrateleira = 2;

 -- MOSTRAR SE TEM ALGO NESSA PRATELEIRA ATRÁVES DO SENSOR DE BLOQUEIO
SELECT idSensor FROM sensor WHERE idPrateleira = 2; 
SELECT idSensor, bloqueio, dataHora FROM historico WHERE idSensor IN (4, 5, 6); 

-- MOSTRAR O NÍVEL DA PRATELEIRA DO PRODUTO REFRI COCA COLA ÁS 16:05 DO DIA 12/03/2023
SELECT idProduto FROM produto WHERE nome = 'Refri. Coca Cola';
SELECT idPrateleira, idProduto FROM prateleira WHERE idProduto = 9;
SELECT idSensor FROM sensor WHERE idPrateleira = 3; 
SELECT idSensor, bloqueio, dataHora FROM historico WHERE dataHora = '2023-03-12 18:16:05' AND idSensor IN (7, 8, 9);







