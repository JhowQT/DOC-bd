create or replace PROCEDURE prc_relatorio_json
AS
    CURSOR c_dados IS
        SELECT 
            u.nm_usuario,
            t.tt_trilha_carreira,
            c.cd_comentario
        FROM T_OR_COMENTARIO c
        JOIN T_OR_USUARIO u ON c.id_usuario = u.id_usuario
        JOIN T_OR_TRILHA_CARREIRA t ON c.id_trilha_carreira = t.id_trilha_carreira;

    v_json CLOB;
    v_count NUMBER;
BEGIN

    SELECT COUNT(*) INTO v_count FROM T_OR_COMENTARIO;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20060, 'Nenhum comentário encontrado');
    END IF;

    FOR rec IN c_dados LOOP

        v_json := fn_gera_json_comentario(
            rec.nm_usuario,
            rec.tt_trilha_carreira,
            rec.cd_comentario
        );

        DBMS_OUTPUT.PUT_LINE(v_json);

    END LOOP;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Sem dados');
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Erro de valor');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro geral: ' || SQLERRM);
END;
