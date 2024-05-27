CREATE DATABASE IF NOT EXISTS imuniBrasil;

USE imuniBrasil;

CREATE TABLE IF NOT EXISTS Usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    cidade VARCHAR(100),
    estado VARCHAR(50),
    is_admin BOOLEAN DEFAULT FALSE
);


CREATE TABLE IF NOT EXISTS Vacinas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    faixa_etaria VARCHAR(50),
    doses INT,
    intervalo_doses INT
);

CREATE TABLE IF NOT EXISTS HistoricoVacinal (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    vacina_id INT NOT NULL,
    data_aplicacao DATE NOT NULL,
    dose INT,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id),
    FOREIGN KEY (vacina_id) REFERENCES Vacinas(id)
);

CREATE TABLE IF NOT EXISTS Campanhas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_inicio DATE,
    data_fim DATE,
    prefeitura_id INT,
    FOREIGN KEY (prefeitura_id) REFERENCES Prefeituras(id)
);

CREATE TABLE IF NOT EXISTS Noticias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    conteudo TEXT,
    data_publicacao DATE,
    autor_id INT,
    FOREIGN KEY (autor_id) REFERENCES Usuarios(id)
);


CREATE TABLE IF NOT EXISTS Prefeituras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL
);


DELIMITER //

CREATE PROCEDURE AdicionarUsuario (
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_senha VARCHAR(255),
    IN p_data_nascimento DATE,
    IN p_cidade VARCHAR(100),
    IN p_estado VARCHAR(50),
    IN p_is_admin BOOLEAN
)
BEGIN
    INSERT INTO Usuarios (nome, email, senha, data_nascimento, cidade, estado, is_admin)
    VALUES (p_nome, p_email, p_senha, p_data_nascimento, p_cidade, p_estado, p_is_admin);
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE AdicionarVacina (
    IN p_nome VARCHAR(100),
    IN p_descricao TEXT,
    IN p_faixa_etaria VARCHAR(50),
    IN p_doses INT,
    IN p_intervalo_doses INT
)
BEGIN
    INSERT INTO Vacinas (nome, descricao, faixa_etaria, doses, intervalo_doses)
    VALUES (p_nome, p_descricao, p_faixa_etaria, p_doses, p_intervalo_doses);
END //

DELIMITER ;


DELIMITER //

CREATE TRIGGER AtualizarDataPublicacao
BEFORE INSERT ON Noticias
FOR EACH ROW
BEGIN
    SET NEW.data_publicacao = NOW();
END //

DELIMITER ;


DELIMITER //

CREATE TRIGGER VerificarEmailUnico
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count FROM Usuarios WHERE email = NEW.email;
    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email já cadastrado.';
    END IF;
END //

DELIMITER ;

INSERT INTO Usuarios (nome, email, senha, data_nascimento, cidade, estado, is_admin)
VALUES 
('João Silva', 'joao.silva@example.com', 'senha123', '1985-03-15', 'São Paulo', 'SP', FALSE),
('Maria Souza', 'maria.souza@example.com', 'senha123', '1990-07-22', 'Rio de Janeiro', 'RJ', FALSE),
('Carlos Pereira', 'carlos.pereira@example.com', 'senha123', '1978-11-05', 'Salvador', 'BA', FALSE),
('Ana Lima', 'ana.lima@example.com', 'senha123', '1982-01-10', 'Belo Horizonte', 'MG', FALSE),
('Pedro Santos', 'pedro.santos@example.com', 'senha123', '1995-05-30', 'Porto Alegre', 'RS', FALSE),
('Lucas Rocha', 'lucas.rocha@example.com', 'senha123', '2000-12-25', 'Curitiba', 'PR', FALSE),
('Mariana Costa', 'mariana.costa@example.com', 'senha123', '1988-02-17', 'Manaus', 'AM', FALSE),
('Rafael Almeida', 'rafael.almeida@example.com', 'senha123', '1983-09-03', 'Fortaleza', 'CE', FALSE),
('Camila Ribeiro', 'camila.ribeiro@example.com', 'senha123', '1992-06-14', 'Recife', 'PE', FALSE),
('Thiago Oliveira', 'thiago.oliveira@example.com', 'senha123', '1998-10-20', 'Brasília', 'DF', TRUE);


INSERT INTO Vacinas (nome, descricao, faixa_etaria, doses, intervalo_doses)
VALUES 
('BCG', 'Protege contra a tuberculose.', '0-1 ano', 1, 0),
('Hepatite B', 'Previne a hepatite B.', '0-1 ano', 3, 30),
('Pentavalente', 'Combina cinco vacinas.', '2-6 meses', 3, 60),
('Pneumocócica 10-valente', 'Previne doenças causadas pelo pneumococo.', '2-4 meses', 2, 60),
('Rotavírus', 'Previne gastroenterites causadas pelo rotavírus.', '2-4 meses', 2, 60),
('Meningocócica C', 'Previne a meningite C.', '3-5 meses', 2, 60),
('Febre Amarela', 'Previne a febre amarela.', '9 meses', 1, 0),
('Tríplice Viral', 'Previne sarampo, caxumba e rubéola.', '12 meses', 2, 90),
('Varicela', 'Previne a catapora.', '15 meses', 1, 0),
('HPV', 'Previne o papilomavírus humano.', '9-14 anos', 2, 180);


INSERT INTO HistoricoVacinal (usuario_id, vacina_id, data_aplicacao, dose)
VALUES 
(1, 1, '1985-03-20', 1),
(2, 2, '1990-07-25', 1),
(3, 3, '1978-11-10', 1),
(4, 4, '1982-01-15', 1),
(5, 5, '1995-06-05', 1),
(6, 6, '2000-12-30', 1),
(7, 7, '1988-02-20', 1),
(8, 8, '1983-09-08', 1),
(9, 9, '1992-06-19', 1),
(10, 10, '1998-10-25', 1);


INSERT INTO Campanhas (titulo, descricao, data_inicio, data_fim, prefeitura_id)
VALUES 
('Campanha de Vacinação Contra a Gripe', 'Vacinação anual contra a gripe.', '2024-04-01', '2024-06-30', 1),
('Campanha de Vacinação Contra o Sarampo', 'Imunização contra o sarampo para crianças.', '2024-05-01', '2024-07-31', 2),
('Campanha de Multivacinação', 'Atualização da caderneta de vacinação.', '2024-08-01', '2024-09-30', 3),
('Campanha de Vacinação Contra a Poliomielite', 'Vacinação de crianças menores de 5 anos contra a poliomielite.', '2024-09-01', '2024-11-30', 4),
('Campanha de Vacinação Contra a Febre Amarela', 'Vacinação em áreas de risco.', '2024-10-01', '2024-12-31', 5),
('Campanha de Vacinação Contra o HPV', 'Vacinação de adolescentes contra o HPV.', '2024-11-01', '2024-12-31', 6),
('Campanha de Vacinação Contra a Hepatite B', 'Vacinação contra a hepatite B.', '2024-01-01', '2024-03-31', 7),
('Campanha de Vacinação Contra a Meningite', 'Vacinação de adolescentes e adultos jovens contra a meningite.', '2024-02-01', '2024-04-30', 8),
('Campanha de Vacinação Contra a Dengue', 'Vacinação em áreas endêmicas.', '2024-03-01', '2024-05-31', 9),
('Campanha de Vacinação Contra a Varicela', 'Vacinação de crianças contra a varicela.', '2024-04-01', '2024-06-30', 10);


INSERT INTO Noticias (titulo, conteudo, data_publicacao, autor_id)
VALUES 
('Nova Campanha de Vacinação Contra a Gripe Inicia em Abril', 'A campanha de vacinação contra a gripe começa no dia 1º de abril.', NOW(), 10),
('Vacinação Contra o Sarampo Para Crianças', 'A campanha de vacinação contra o sarampo começa em maio.', NOW(), 10),
('Campanha de Multivacinação Atualiza Cadernetas', 'Campanha de multivacinação começa em agosto.', NOW(), 10),
('Vacinação Contra a Poliomielite Inicia em Setembro', 'Campanha contra a poliomielite começa em setembro.', NOW(), 10),
('Vacinação Contra a Febre Amarela nas Áreas de Risco', 'Campanha de vacinação contra a febre amarela começa em outubro.', NOW(), 10),
('Vacinação Contra o HPV para Adolescentes', 'Campanha de vacinação contra o HPV começa em novembro.', NOW(), 10),
('Vacinação Contra a Hepatite B em Todo o País', 'Campanha de vacinação contra a hepatite B começa em janeiro.', NOW(), 10),
('Vacinação Contra a Meningite para Jovens', 'Campanha de vacinação contra a meningite começa em fevereiro.', NOW(), 10),
('Vacinação Contra a Dengue em Áreas Endêmicas', 'Campanha de vacinação contra a dengue começa em março.', NOW(), 10),
('Vacinação Contra a Varicela para Crianças', 'Campanha de vacinação contra a varicela começa em abril.', NOW(), 10);


INSERT INTO Prefeituras (nome, cidade, estado)
VALUES 
('Prefeitura de São Paulo', 'São Paulo', 'SP'),
('Prefeitura do Rio de Janeiro', 'Rio de Janeiro', 'RJ'),
('Prefeitura de Salvador', 'Salvador', 'BA'),
('Prefeitura de Belo Horizonte', 'Belo Horizonte', 'MG'),
('Prefeitura de Porto Alegre', 'Porto Alegre', 'RS'),
('Prefeitura de Curitiba', 'Curitiba', 'PR'),
('Prefeitura de Manaus', 'Manaus', 'AM'),
('Prefeitura de Fortaleza', 'Fortaleza', 'CE'),
('Prefeitura de Recife', 'Recife', 'PE'),
('Prefeitura de Brasília', 'Brasília', 'DF');

-- Consulta do Histórico Vacinal de um Usuário
SELECT v.nome, h.data_aplicacao, h.dose
FROM HistoricoVacinal h
JOIN Vacinas v ON h.vacina_id = v.id
WHERE h.usuario_id = ?;

SELECT v.nome, h.data_aplicacao, h.dose
FROM HistoricoVacinal h
JOIN Vacinas v ON h.vacina_id = v.id
WHERE h.usuario_id = 1;

-- Consulta de Campanhas Atuais
SELECT * FROM Campanhas
WHERE CURDATE() BETWEEN data_inicio AND data_fim;

-- Consulta de Vacinas Disponíveis por Faixa Etária
SELECT * FROM Vacinas
WHERE faixa_etaria = 0 or ?;

SELECT * FROM Vacinas
WHERE faixa_etaria = 0 or 1;


