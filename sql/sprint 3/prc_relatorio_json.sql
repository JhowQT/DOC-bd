CREATE OR REPLACE PROCEDURE prc_relatorio_json (
    p_result OUT CLOB
)
AS
    v_json CLOB := '';
    v_count NUMBER;
BEGIN

    SELECT COUNT(*) INTO v_count FROM T_OR_COMENTARIO;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20060, 'Nenhum comentário encontrado');
    END IF;

    FOR rec IN (
        SELECT 
            u.nm_usuario,
            t.tt_trilha_carreira,
            c.cd_comentario
        FROM T_OR_COMENTARIO c
        JOIN T_OR_USUARIO u ON c.id_usuario = u.id_usuario
        JOIN T_OR_TRILHA_CARREIRA t ON c.id_trilha_carreira = t.id_trilha_carreira
    ) LOOP

        v_json := v_json ||
            fn_gera_json_comentario(
                rec.nm_usuario,
                rec.tt_trilha_carreira,
                rec.cd_comentario
            ) || CHR(10);

    END LOOP;

    p_result := v_json;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_result := 'Erro: Nenhum dado encontrado';

    WHEN VALUE_ERROR THEN
        p_result := 'Erro: Problema de conversão de dados';

    WHEN OTHERS THEN
        p_result := 'Erro geral: ' || SQLERRM;
END;
/