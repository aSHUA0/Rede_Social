SELECT P.CONTEUDO AS POSTAGEM, COUNT(C.ID_COMENTARIO) AS TOTAL_COMENTARIOS, P.AMEI
FROM POSTAGEM P
LEFT JOIN COMENTARIO C ON P.ID_POSTAGEM = C.FK_ID_POSTAGEM
GROUP BY P.ID_POSTAGEM
ORDER BY P.AMEI DESC;

SELECT U.NOME_USUARIO as USUARIO
FROM USUARIO U
LEFT JOIN USUARIO_GRUPO UG ON U.ID_USUARIO = UG.ID_USUARIO
WHERE UG.ID_GRUPO IS NULL;

SELECT M.NOME_MEMBRO AS MEMBRO, G.NOME_GRUPO AS GRUPO
FROM MEMBRO M
JOIN GRUPO G ON M.FK_ID_GRUPO = G.ID_GRUPO
WHERE M.DATA_ENTRADA > '2024-10-01';

SELECT T.NOME_TAG, COUNT(UT.ID_USUARIO) AS TOTAL_USUARIOS
FROM TAG T
LEFT JOIN USUARIO_TAG UT ON T.ID_TAG = UT.ID_TAG
GROUP BY T.ID_TAG
ORDER BY TOTAL_USUARIOS DESC;

SELECT 
    USUARIO.NOME_USUARIO, 
    CONVERSA.MENSAGEM, 
    CONVERSA.STATUS_MESNAGEM 
FROM CONVERSA
JOIN USUARIO ON CONVERSA.FK_ID_USUARIO = USUARIO.ID_USUARIO
WHERE CONVERSA.STATUS_MESNAGEM = 'Não Visto';

/*Trigger*/

DELIMITER $$
CREATE TRIGGER contagemGrupo
AFTER INSERT ON MEMBRO
FOR EACH ROW
BEGIN
    UPDATE GRUPO
    SET DESC_G = CONCAT('Este grupo possui ', 
                        (SELECT COUNT(*) FROM MEMBRO WHERE FK_ID_GRUPO = NEW.FK_ID_GRUPO),
                        ' membros.')
	WHERE ID_GRUPO = NEW.FK_ID_GRUPO;
END$$
DELIMITER ;

/*Procedure*/

DELIMITER $$
CREATE PROCEDURE EnviarMensagem(
	IN p_mensagem VARCHAR(255),
	IN p_data_mensagem DATETIME,
	IN p_status_mensagem VARCHAR(20),
	IN p_id_usuario INT,
	IN p_id_contato INT
)
BEGIN

	INSERT INTO CONVERSA (MENSAGEM, DATA_MENSAGEM, STATUS_MENSAGEM, FK_ID_USUARIO, FK_ID_CONTATO)
	VALUES (p_mensagem, p_data_mensagem, p_status_mensagem, p_id_usuario, p_id_contato);
    
    SELECT MENSAGEM, DATA_MENSAGEM, STATUS_MENSAGEM FROM CONVERSA
    ORDER BY ID_CONVERSA DESC
    LIMIT 1;

END$$
DELIMITER ;

CALL EnviarMensagem('Olá! Como você está?', NOW(), 'Enviado', 1, 2);

/*Procedure*/

DELIMITER $$
CREATE PROCEDURE PostagemUsuario(
	IN U_NOME_USUARIO varchar(50)
)
BEGIN
	SELECT P.CONTEUDO, P.AMEI, P.NAO_AMEI, P.DATA_PUBLIC, COUNT(ID_COMENTARIO) AS COMENTARIOS
	FROM POSTAGEM AS P
    INNER JOIN USUARIO ON FK_ID_USUARIO = ID_USUARIO
    INNER JOIN COMENTARIO ON FK_ID_POSTAGEM = ID_POSTAGEM
	WHERE NOME_USUARIO = 'Maria Oliveira'
    GROUP BY ID_POSTAGEM
    ORDER BY DATA_PUBLIC DESC;
END$$
DELIMITER ;
    
CALL PostagemUsuario('Maria Oliveira');
