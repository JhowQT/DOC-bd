CREATE OR REPLACE PROCEDURE prc_relatorio_sequencial
AS
    v_count NUMBER;
BEGIN

    SELECT COUNT(*) 
    INTO v_count 
    FROM T_OR_COMENTARIO;

    IF v_count < 5 THEN
        RAISE_APPLICATION_ERROR(-20070, 'Quantidade insuficiente de dados');
    END IF;

    FOR rec IN (
        SELECT 
            id_comentario,

            NVL(
                LAG(DBMS_LOB.SUBSTR(cd_comentario, 4000, 1)) 
                OVER (ORDER BY id_comentario),
                'Vazio'
            ) AS anterior,

            DBMS_LOB.SUBSTR(cd_comentario, 4000, 1) AS atual,

            NVL(
                LEAD(DBMS_LOB.SUBSTR(cd_comentario, 4000, 1)) 
                OVER (ORDER BY id_comentario),
                'Vazio'
            ) AS proximo

        FROM T_OR_COMENTARIO
    ) LOOP

        DBMS_OUTPUT.PUT_LINE(
            'ID: ' || rec.id_comentario ||
            ' | Anterior: ' || rec.anterior ||
            ' | Atual: ' || rec.atual ||
            ' | Próximo: ' || rec.proximo
        );

    END LOOP;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Sem dados');

    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Erro de valor');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro geral: ' || SQLERRM);

END;
/