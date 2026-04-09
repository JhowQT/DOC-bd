CREATE OR REPLACE PROCEDURE prc_relatorio_sequencial (
    p_result OUT CLOB
)
AS
    v_result CLOB := '';
    v_count NUMBER;
BEGIN

    SELECT COUNT(*) INTO v_count FROM T_OR_COMENTARIO;

    IF v_count < 5 THEN
        RAISE_APPLICATION_ERROR(-20070, 'Quantidade insuficiente de dados');
    END IF;

    FOR rec IN (
        SELECT 
            id_comentario,

            NVL(LAG(DBMS_LOB.SUBSTR(cd_comentario,4000,1)) 
                OVER (ORDER BY id_comentario),'Vazio') anterior,

            DBMS_LOB.SUBSTR(cd_comentario,4000,1) atual,

            NVL(LEAD(DBMS_LOB.SUBSTR(cd_comentario,4000,1)) 
                OVER (ORDER BY id_comentario),'Vazio') proximo

        FROM T_OR_COMENTARIO
    ) LOOP

        v_result := v_result ||
            'ID: ' || rec.id_comentario ||
            ' | Anterior: ' || rec.anterior ||
            ' | Atual: ' || rec.atual ||
            ' | Próximo: ' || rec.proximo || CHR(10);

    END LOOP;

    p_result := v_result;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_result := 'Erro: Nenhum dado encontrado';

    WHEN VALUE_ERROR THEN
        p_result := 'Erro: Problema ao manipular dados';

    WHEN OTHERS THEN
        p_result := 'Erro geral: ' || SQLERRM;
END;
/