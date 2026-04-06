CREATE OR REPLACE PROCEDURE prc_insere_trilha_carreira(
    p_titulo IN VARCHAR2,
    p_conteudo IN CLOB
) AS
BEGIN
    INSERT INTO T_OR_TRILHA_CARREIRA (tt_trilha_carreira, cd_trilha_carreira)
    VALUES (p_titulo, p_conteudo);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20010, 'Erro ao inserir trilha de carreira: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE prc_update_trilha_carreira(
    p_id_trilha IN NUMBER,
    p_titulo IN VARCHAR2,
    p_conteudo IN CLOB
) AS
BEGIN
    UPDATE T_OR_TRILHA_CARREIRA
       SET tt_trilha_carreira = p_titulo,
           cd_trilha_carreira = p_conteudo
     WHERE id_trilha_carreira = p_id_trilha;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20011, 'Trilha de carreira não encontrada.');
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20012, 'Erro ao atualizar trilha de carreira: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE prc_delete_trilha_carreira(
    p_id_trilha IN NUMBER
) AS
BEGIN
    DELETE FROM T_OR_TRILHA_CARREIRA
     WHERE id_trilha_carreira = p_id_trilha;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20013, 'Trilha de carreira não encontrada para exclusão.');
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20014, 'Erro ao excluir trilha de carreira: ' || SQLERRM);
END;
/
