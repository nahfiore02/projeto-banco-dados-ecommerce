-- ************************************************************
-- PROJETO CONCEITUAL DE BANCO DE DADOS - E-COMMERCE
-- Script SQL para MySQL / MariaDB (com dados aleatórios)
-- ************************************************************

-- 1. Criação e seleção do Banco de Dados
CREATE DATABASE IF NOT EXISTS db_ecommerce_projeto;
USE db_ecommerce_projeto;

-- ************************************************************
-- 2. CRIAÇÃO DAS TABELAS
-- ************************************************************

-- Tabela 1: CLIENTES
CREATE TABLE Clientes (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nome_completo VARCHAR(150) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    data_cadastro DATE NOT NULL
);

-- Tabela 2: CATEGORIAS (Para classificar os produtos)
CREATE TABLE Categorias (
    categoria_id INT PRIMARY KEY AUTO_INCREMENT,
    nome_categoria VARCHAR(50) UNIQUE NOT NULL,
    descricao TEXT
);

-- Tabela 3: PRODUTOS (Com chave estrangeira para Categorias)
CREATE TABLE Produtos (
    produto_id INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL CHECK (preco >= 0),
    estoque INT DEFAULT 0 CHECK (estoque >= 0),
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES Categorias(categoria_id)
);

-- Tabela 4: PEDIDOS (Com chave estrangeira para Clientes)
CREATE TABLE Pedidos (
    pedido_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    data_pedido DATETIME NOT NULL,
    status_pedido ENUM('Pendente', 'Processando', 'Enviado', 'Entregue', 'Cancelado') NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id)
);

-- Tabela 5: ITENS_PEDIDO (Tabela de ligação N:M entre Pedidos e Produtos)
CREATE TABLE Itens_Pedido (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    preco_unitario DECIMAL(10, 2) NOT NULL,
    UNIQUE KEY (pedido_id, produto_id),
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(pedido_id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id)
);

-- Tabela 6: ENDERECOS (Um cliente pode ter vários endereços)
CREATE TABLE Enderecos (
    endereco_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    logradouro VARCHAR(150) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    tipo_endereco ENUM('Principal', 'Entrega', 'Cobrança') NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id)
);

-- ************************************************************
-- 3. INSERÇÃO DE DADOS DE EXEMPLO COM NOMES ALEATÓRIOS
-- ************************************************************

-- Inserindo Clientes
INSERT INTO Clientes (nome_completo, email, telefone, data_cadastro) VALUES
('Rafael Oliveira', 'rafael.oli@techshop.com', '11987654321', '2023-08-10'),
('Juliana Santos', 'juh.santos@lojamais.com', '21912345678', '2023-09-01'),
('Felipe Martins', 'felipe.mart@email.com', '31998765432', '2023-10-15'),
('Mariana Lima', 'mariana.l@webmail.com', '47900001111', '2023-11-22'),
('Pedro Almeida', 'pedro.almeida@mail.co', '81955554444', '2023-12-05');

-- Inserindo Categorias
INSERT INTO Categorias (nome_categoria, descricao) VALUES
('Informática', 'Hardware, Software e Periféricos'),
('Casa e Decoração', 'Móveis, utensílios e objetos de arte'),
('Esportes', 'Artigos para diversas modalidades esportivas');

-- Inserindo Produtos
INSERT INTO Produtos (nome_produto, descricao, preco, estoque, categoria_id) VALUES
('Mouse Óptico Pro', 'Mouse ergonômico com alta precisão.', 99.90, 80, 1),
('Livro Receitas Gourmet', 'Coleção de receitas de chefs renomados.', 120.00, 45, 2),
('Bola de Futebol Oficial', 'Bola de couro sintético, padrão FIFA.', 250.00, 30, 3),
('Monitor LED 27"', 'Tela Full HD de alta definição para jogos.', 1899.50, 20, 1),
('Conjunto de Taças (6 un.)', 'Taças de cristal para vinho tinto.', 150.99, 60, 2);

-- Inserindo Pedidos
INSERT INTO Pedidos (cliente_id, data_pedido, status_pedido, valor_total) VALUES
(1, '2024-01-10 10:30:00', 'Entregue', 1899.50), -- Rafael: 1 Monitor
(2, '2024-01-12 15:45:00', 'Processando', 400.00), -- Juliana: 1 Bola + 1 Mouse (Total Ajustado Manualmente)
(3, '2024-01-15 09:00:00', 'Enviado', 270.99); -- Felipe: 1 Livro + 1 Conjunto de Taças (Total Ajustado Manualmente)

-- Inserindo Itens_Pedido
INSERT INTO Itens_Pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 4, 1, 1899.50), -- Pedido 1: 1 Monitor
(2, 3, 1, 250.00),  -- Pedido 2: 1 Bola
(2, 1, 1, 99.90),   -- Pedido 2: 1 Mouse Óptico
(3, 2, 1, 120.00),  -- Pedido 3: 1 Livro
(3, 5, 1, 150.99);  -- Pedido 3: 1 Conjunto de Taças

-- Inserindo Endereços
INSERT INTO Enderecos (cliente_id, logradouro, cidade, estado, cep, tipo_endereco) VALUES
(1, 'Rua das Acácias, 45', 'Belo Horizonte', 'MG', '30000-000', 'Principal'),
(2, 'Av. Paulista, 1500', 'São Paulo', 'SP', '01310-200', 'Entrega'),
(3, 'Travessa A, 10', 'Curitiba', 'PR', '80000-000', 'Principal');
