CREATE OR REPLACE FUNCTION fn_valida_comentario(
    p_cd_comentario IN CLOB,
    p_at_comentario IN CHAR,
    p_id_usuario IN INTEGER,
    p_id_trilha_carreira IN INTEGER
)
RETURN BOOLEAN
AS
    v_user_count NUMBER;
    v_trilha_count NUMBER;
BEGIN

    IF p_cd_comentario IS NULL OR LENGTH(TRIM(p_cd_comentario)) = 0 THEN
        RAISE_APPLICATION_ERROR(-20200, 'Comentário não pode ser vazio.');
    END IF;

    IF p_at_comentario NOT IN ('0', '1') THEN
        RAISE_APPLICATION_ERROR(-20201, 'Status do comentário inválido (use 0 ou 1).');
    END IF;

    SELECT COUNT(*) INTO v_user_count
      FROM T_OR_USUARIO
     WHERE id_usuario = p_id_usuario;

    IF v_user_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20202, 'Usuário informado não existe.');
    END IF;

    SELECT COUNT(*) INTO v_trilha_count
      FROM T_OR_TRILHA_CARREIRA
     WHERE id_trilha_carreira = p_id_trilha_carreira;

    IF v_trilha_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20203, 'Trilha informada não existe.');
    END IF;

    RETURN TRUE;
EXCEPTION
    WHEN OTHERS THEN
        RETURN FALSE;
END;
/
