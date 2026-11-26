
-- Tabela: INSTITUICAO
CREATE TABLE INSTITUICAO (
id_instituicao INTEGER PRIMARY KEY,
nome TEXT,
tipo TEXT,
estado TEXT
);

-- Tabela: INCIDENTE
CREATE TABLE INCIDENTE (
id_incidente INTEGER PRIMARY KEY,
descricao TEXT,
data_incidente TEXT,
quantidade_afetados INTEGER,
id_instituicao INTEGER,
situacao TEXT,
FOREIGN KEY (id_instituicao) REFERENCES INSTITUICAO(id_instituicao)
);

-- Tabela: DADOS_EXPOSTOS
CREATE TABLE DADOS_EXPOSTOS (
id_dado INTEGER PRIMARY KEY,
tipo_dado TEXT,
nivel_risco TEXT,
id_incidente INTEGER,
FOREIGN KEY (id_incidente) REFERENCES INCIDENTE(id_incidente)
);


-- Inserindo Instituições
INSERT INTO INSTITUICAO (id_instituicao, nome, tipo, estado) VALUES
(1, 'Instituição Financeira Alfa', 'Financeiro', 'SP'),
(2, 'Instituto Público Beta', 'Público', 'RJ'),
(3, 'Empresa de Tecnologia Gama', 'Privado', 'MG');

-- Inserindo Incidentes
INSERT INTO INCIDENTE (id_incidente, descricao, data_incidente, quantidade_afetados, id_instituicao, situacao) VALUES
(1, 'Vazamento de dados via Phishing', '2023-10-10', 1500, 1, 'Em investigação'),
(2, 'Ataque Ransomware no servidor principal', '2023-10-25', 5000, 2, 'Em investigação'),
(3, 'Acesso não autorizado ao banco de dados', '2023-11-05', 300, 3, 'Controlado');

-- Inserindo Dados Expostos
INSERT INTO DADOS_EXPOSTOS (id_dado, tipo_dado, nivel_risco, id_incidente) VALUES
(1, 'CPF', 'Alto', 1),
(2, 'E-mail', 'Médio', 1),
(3, 'Endereço', 'Baixo', 2),
(4, 'Dados Cadastrais (Nome/RG)', 'Alto', 3),
(5, 'Telefone', 'Médio', 3);



-- 1. Listar todas as instituições cadastradas.
SELECT * FROM INSTITUICAO;

-- 2. Localizar incidentes classificados como de alto risco.
SELECT * FROM DADOS_EXPOSTOS WHERE nivel_risco = 'Alto';

-- 3. Ordenar os incidentes pela quantidade de pessoas afetadas (decrescente).
SELECT * FROM INCIDENTE ORDER BY quantidade_afetados DESC;

-- 4. Apresentar o nome da instituição, a descrição do incidente e a quantidade de afetados.
SELECT
I.nome AS Nome_Instituicao,
INC.descricao AS Descricao_Incidente,
INC.quantidade_afetados AS Total_Afetados
FROM INSTITUICAO I
INNER JOIN INCIDENTE INC ON I.id_instituicao = INC.id_instituicao;

-- 5. Contabilizar quantos registros de dados expostos existem por tipo de informação.
SELECT tipo_dado, COUNT(*) AS Quantidade_Registros
FROM DADOS_EXPOSTOS
GROUP BY tipo_dado;

-- 6. Alterar a situação de um incidente de "Em investigação" para "Controlado".
UPDATE INCIDENTE
SET situacao = 'Controlado'
WHERE id_incidente = 1 AND situacao = 'Em investigação';

-- (Opcional) Verificar a alteração do UPDATE:
-- SELECT * FROM INCIDENTE;
