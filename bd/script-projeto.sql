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
	(0001, 'Desinfetante Multiuso', 'Higiene e limpeza', 'Veja', 'ml', '500'),
    (0023, 'Refrigerante guaraná', 'Adega e bebidas', 'Veja', 'L', '2.00'),
    (0120, 'Bolacha Recheada Passatempo', 'Cereais', 'Nestle', 'g', '2.00'),
    (0009, 'Refri. Coca Cola', 'Adega e bebidas', 'Coca Cola', 'L', '2.00'),
    (0442, 'Arroz', 'Alimentos', 'Camil', 'Kg', '5.00'),
    (0050, 'Feijão', 'Alimentos', 'Camil', 'Kg', '2.00');

insert into prateleira (idProduto, corredor, setor, obs) values
	(0023, '09', 'Bebidas', 'O produto se localiza no centro da prateleiera'),
    (0001, '02', 'Higiene Limpeza', 'O produto se localiza no início da prateleiera'),
    (0009, '09', 'Bebidas', 'O produto se localiza nas prateleiras de cima'),
    (0050, '04', 'Alimentício', 'Presente nas prateleiras de baixo'),
    (0120, '07', 'Cereais', 'Se encontra de frente para os produtos x'),
    (0442, '04', 'Alimentício', 'Entre os produtos X e Y');

insert into sensor (idPrateleira, sttSensor, bloqueio) values
	(1, 'Em funcionamento', 1),
    (1, 'Em funcionamento', 1),
    (1, 'Em funcionamento', 0),
    (2, 'Em funcionamento', 0),
    (2, 'Desativado', 0),
    (2, 'Em manutenção', 0),
	(3, 'Em funcionamento', 1),
    (3, 'Em funcionamento', 0),
    (3, 'Em funcionamento', 0);

insert into historico (idSensor, dataHora) values
	(1, DEFAULT),
    (2, DEFAULT),
    (3, DEFAULT),
    (4, DEFAULT),
    (5, DEFAULT),
    (6, DEFAULT);
    
SELECT * FROM usuario;
SELECT * FROM produto;    
SELECT * FROM prateleira; 
SELECT * FROM sensor; 
SELECT * FROM historico;

-- SELECIONAR OS SENSORES DA PRATELEIRA ID = 1 
SELECT idSensor FROM sensor WHERE idPrateleira = 1; 

-- NIVÉL DA PRATELEIRA ID = 2
SELECT idSensor, bloqueio FROM sensor WHERE idPrateleira = 2;

-- O INFORMAÇÕES DO PRODUTO DA PRATELEIRA ID = 3
SELECT idProduto FROM prateleira WHERE idPrateleira = 3;
SELECT * FROM produto WHERE idProduto = 9;

-- HISTÓRICO DOS SENSORES 1,2,3 = prateleira 1
SELECT dataHora, idSensor FROM historico WHERE idSensor IN(1, 2, 3);

-- SELECIONAR TODAS AS PRATELEIRAS DO SETOR DE BEBIDAS E CHECAR O NIVÉL DE PRODUTOS DELAS
SELECT * FROM prateleira WHERE setor ='Bebidas';
SELECT idPrateleira, bloqueio FROM sensor WHERE idPrateleira IN(1, 3);

    





