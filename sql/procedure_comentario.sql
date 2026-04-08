CREATE OR REPLACE PROCEDURE prc_insere_comentario(
    p_cd_comentario IN CLOB,
    p_at_comentario IN CHAR,
    p_id_usuario IN INTEGER,
    p_id_trilha_carreira IN INTEGER
) AS
    v_score NUMBER;
BEGIN

    -- 🔴 NOVA REGRA DE NEGÓCIO (USANDO A FUNÇÃO)
    v_score := fn_score_trilha(p_id_trilha_carreira);

    IF v_score > 100 THEN
        RAISE_APPLICATION_ERROR(-20900, 'Trilha com muitas interações. Comentário bloqueado.');
    END IF;

    -- 🔴 VALIDAÇÃO BÁSICA (mantida parcialmente)
    IF p_cd_comentario IS NULL OR LENGTH(TRIM(p_cd_comentario)) = 0 THEN
        RAISE_APPLICATION_ERROR(-20200, 'Comentário não pode ser vazio.');
    END IF;

    IF p_at_comentario NOT IN ('0', '1') THEN
        RAISE_APPLICATION_ERROR(-20201, 'Status do comentário inválido.');
    END IF;

    -- 🔴 INSERÇÃO
    INSERT INTO T_OR_COMENTARIO (cd_comentario, at_comentario, id_usuario, id_trilha_carreira)
    VALUES (p_cd_comentario, p_at_comentario, p_id_usuario, p_id_trilha_carreira);

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20205, 'Erro ao inserir comentário: ' || SQLERRM);
END;
/