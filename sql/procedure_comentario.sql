CREATE OR REPLACE PROCEDURE prc_insere_comentario(
    p_cd_comentario IN CLOB,
    p_at_comentario IN CHAR,
    p_id_usuario IN INTEGER,
    p_id_trilha_carreira IN INTEGER
) AS
BEGIN

    IF NOT fn_valida_comentario(p_cd_comentario, p_at_comentario, p_id_usuario, p_id_trilha_carreira) THEN
        RAISE_APPLICATION_ERROR(-20204, 'Falha na validação dos dados do comentário.');
    END IF;

    INSERT INTO T_OR_COMENTARIO (cd_comentario, at_comentario, id_usuario, id_trilha_carreira)
    VALUES (p_cd_comentario, p_at_comentario, p_id_usuario, p_id_trilha_carreira);

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20205, 'Erro ao inserir comentário: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE prc_update_comentario(
    p_id_comentario IN INTEGER,
    p_cd_comentario IN CLOB,
    p_at_comentario IN CHAR,
    p_id_usuario IN INTEGER,
    p_id_trilha_carreira IN INTEGER
) AS
BEGIN

    IF NOT fn_valida_comentario(p_cd_comentario, p_at_comentario, p_id_usuario, p_id_trilha_carreira) THEN
        RAISE_APPLICATION_ERROR(-20206, 'Falha na validação dos dados do comentário.');
    END IF;

    UPDATE T_OR_COMENTARIO
       SET cd_comentario = p_cd_comentario,
           at_comentario = p_at_comentario,
           id_usuario = p_id_usuario,
           id_trilha_carreira = p_id_trilha_carreira
     WHERE id_comentario = p_id_comentario;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20207, 'Comentário não encontrado para atualização.');
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20208, 'Erro ao atualizar comentário: ' || SQLERRM);
END;
/


CREATE OR REPLACE PROCEDURE prc_delete_comentario(
    p_id_comentario IN INTEGER
) AS
BEGIN
    DELETE FROM T_OR_COMENTARIO
     WHERE id_comentario = p_id_comentario;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20021, 'Comentário não encontrado para exclusão.');
    END IF;

    COMMIT;
END;
/

