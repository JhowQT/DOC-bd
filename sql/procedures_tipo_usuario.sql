CREATE OR REPLACE PROCEDURE prc_insere_tipo_usuario(
    p_nome_tipo IN VARCHAR2
) AS
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count
      FROM T_OR_TIPO_USUARIO
     WHERE LOWER(nm_tipo_usuario) = LOWER(p_nome_tipo);

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Já existe um tipo de usuário com esse nome.');
    END IF;

    INSERT INTO T_OR_TIPO_USUARIO (nm_tipo_usuario)
    VALUES (p_nome_tipo);

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'Erro ao inserir tipo de usuário: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE prc_update_tipo_usuario(
    p_id_tipo IN NUMBER,
    p_nome_tipo IN VARCHAR2
) AS
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count
      FROM T_OR_TIPO_USUARIO
     WHERE LOWER(nm_tipo_usuario) = LOWER(p_nome_tipo)
       AND id_tipo_usuario <> p_id_tipo;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Já existe outro tipo de usuário com esse nome.');
    END IF;

    UPDATE T_OR_TIPO_USUARIO
       SET nm_tipo_usuario = p_nome_tipo
     WHERE id_tipo_usuario = p_id_tipo;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Tipo de usuário não encontrado.');
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20005, 'Erro ao atualizar tipo de usuário: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE prc_delete_tipo_usuario(
    p_id_tipo IN NUMBER
) AS
BEGIN
    DELETE FROM T_OR_TIPO_USUARIO
     WHERE id_tipo_usuario = p_id_tipo;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20006, 'Tipo de usuário não encontrado para exclusão.');
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20007, 'Erro ao excluir tipo de usuário: ' || SQLERRM);
END;
/
