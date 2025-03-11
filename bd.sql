CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    categoria VARCHAR(50),
    imagem_url TEXT,
    usuario_id INT REFERENCES usuarios(id) ON DELETE CASCADE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE enderecos (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id) ON DELETE CASCADE,
    rua VARCHAR(255) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    complemento TEXT
);

CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id) ON DELETE CASCADE,
    endereco_id INT REFERENCES enderecos(id) ON DELETE SET NULL,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'Pendente',
    total DECIMAL(10,2) NOT NULL
);
CREATE TABLE carrinho (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id) ON DELETE CASCADE,
    produto_id INT REFERENCES produtos(id) ON DELETE CASCADE,
    quantidade INT DEFAULT 1,
    data_adicao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT carrinho_usuario_produto_unique UNIQUE (usuario_id, produto_id)
);
INSERT INTO usuarios (nome, email, senha) VALUES
('Alice Silva', 'alice@email.com', 'senha123'),
('Bruno Santos', 'bruno@email.com', 'senha456'),
('Carlos Oliveira', 'carlos@email.com', 'senha789');

INSERT INTO enderecos (usuario_id, rua, cidade, estado, cep, pais, complemento) VALUES
(16, 'Rua das Flores, 123', 'São Paulo', 'SP', '01010-000', 'Brasil', 'Apto 12B'),
(17, 'Avenida Central, 456', 'Rio de Janeiro', 'RJ', '20020-000', 'Brasil', 'Bloco C'),
(18, 'Rua do Comércio, 789', 'Belo Horizonte', 'MG', '30130-000', 'Brasil', NULL);

INSERT INTO produtos (nome, descricao, preco, categoria, imagem_url, usuario_id) VALUES
('Camisa Polo', 'Camisa polo de algodão', 59.90, 'Roupas', 'https://i.imgur.com/0XEOL1m.jpeg', 16),
('Tênis Esportivo', 'Tênis confortável para corrida', 199.90, 'Calçados', 'https://i.imgur.com/5laXagE.jpeg', 17),
('Smartphone XYZ', 'Celular com 128GB de armazenamento', 1499.00, 'Eletrônicos', 'https://exemplo.com/imagem3.jpg', 18);

INSERT INTO pedidos (usuario_id, endereco_id, status, total) VALUES
(17, 1, 'Pendente', 259.80),
(16, 2, 'Enviado', 199.90),
(18, NULL, 'Cancelado', 0.00);