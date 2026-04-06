CREATE OR REPLACE PROCEDURE prc_insere_usuario(
    p_nome IN VARCHAR2,
    p_email IN VARCHAR2,
    p_senha IN VARCHAR2,
    p_at_usuario IN CHAR,
    p_id_tipo_usuario IN NUMBER
) AS
    v_count INTEGER;
BEGIN
    IF NOT fn_valida_usuario(p_nome, p_email, p_senha, p_at_usuario, p_id_tipo_usuario) THEN
        RAISE_APPLICATION_ERROR(-20105, 'Falha na validação de dados do usuário.');
    END IF;

    SELECT COUNT(*) INTO v_count
      FROM T_OR_USUARIO
     WHERE LOWER(email) = LOWER(p_email);

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20010, 'Já existe um usuário cadastrado com este e-mail.');
    END IF;

    INSERT INTO T_OR_USUARIO (nm_usuario, email, senha, at_usuario, id_tipo_usuario)
    VALUES (p_nome, p_email, p_senha, p_at_usuario, p_id_tipo_usuario);

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20011, 'Erro ao inserir usuário: ' || SQLERRM);
END;
/


CREATE OR REPLACE PROCEDURE prc_update_usuario(
    p_id_usuario IN NUMBER,
    p_nome IN VARCHAR2,
    p_email IN VARCHAR2,
    p_senha IN VARCHAR2,
    p_at_usuario IN CHAR,
    p_id_tipo_usuario IN NUMBER
) AS
    v_count INTEGER;
BEGIN

    IF NOT fn_valida_usuario(p_nome, p_email, p_senha, p_at_usuario, p_id_tipo_usuario) THEN
        RAISE_APPLICATION_ERROR(-20106, 'Falha na validação de dados do usuário.');
    END IF;

    SELECT COUNT(*) INTO v_count
      FROM T_OR_USUARIO
     WHERE LOWER(email) = LOWER(p_email)
       AND id_usuario <> p_id_usuario;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20012, 'E-mail já cadastrado para outro usuário.');
    END IF;

    UPDATE T_OR_USUARIO
       SET nm_usuario = p_nome,
           email = p_email,
           senha = p_senha,
           at_usuario = p_at_usuario,
           id_tipo_usuario = p_id_tipo_usuario
     WHERE id_usuario = p_id_usuario;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20013, 'Usuário não encontrado para atualização.');
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20014, 'Erro ao atualizar usuário: ' || SQLERRM);
END;
/


CREATE OR REPLACE PROCEDURE prc_delete_usuario(
    p_id_usuario IN NUMBER
) AS
BEGIN
    DELETE FROM T_OR_USUARIO
     WHERE id_usuario = p_id_usuario;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20015, 'Usuário não encontrado para exclusão.');
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20016, 'Erro ao excluir usuário: ' || SQLERRM);
END;
/
