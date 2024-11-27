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
