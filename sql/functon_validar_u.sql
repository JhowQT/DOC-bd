CREATE OR REPLACE FUNCTION fn_valida_usuario(
    p_nome IN VARCHAR2,
    p_email IN VARCHAR2,
    p_senha IN VARCHAR2,
    p_at_usuario IN CHAR,
    p_id_tipo_usuario IN NUMBER
)
RETURN BOOLEAN
AS
    v_tipo_count INTEGER;
BEGIN

    IF p_nome IS NULL OR LENGTH(TRIM(p_nome)) = 0 THEN
        RAISE_APPLICATION_ERROR(-20100, 'Nome do usuário não pode ser vazio.');
    END IF;

    IF p_email IS NULL OR INSTR(p_email, '@') = 0 THEN
        RAISE_APPLICATION_ERROR(-20101, 'E-mail inválido.');
    END IF;

    IF p_senha IS NULL OR LENGTH(TRIM(p_senha)) < 3 THEN
        RAISE_APPLICATION_ERROR(-20102, 'Senha inválida (mínimo 3 caracteres).');
    END IF;

    IF p_at_usuario NOT IN ('0', '1') THEN
        RAISE_APPLICATION_ERROR(-20103, 'Status de usuário inválido (use 0 ou 1).');
    END IF;

    SELECT COUNT(*) INTO v_tipo_count
      FROM T_OR_TIPO_USUARIO
     WHERE id_tipo_usuario = p_id_tipo_usuario;

    IF v_tipo_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20104, 'Tipo de usuário informado não existe.');
    END IF;

    RETURN TRUE;
EXCEPTION
    WHEN OTHERS THEN
        RETURN FALSE;
END;
/
