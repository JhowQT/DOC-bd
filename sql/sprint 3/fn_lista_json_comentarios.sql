CREATE OR REPLACE FUNCTION fn_lista_json_comentarios
RETURN CLOB
AS
    v_json CLOB := '[';
    v_first BOOLEAN := TRUE;
BEGIN

    FOR rec IN (
        SELECT id_comentario 
        FROM T_OR_COMENTARIO
    ) LOOP

        IF NOT v_first THEN
            v_json := v_json || ',';
        END IF;

        v_json := v_json || fn_json_comentario_por_id(rec.id_comentario);

        v_first := FALSE;

    END LOOP;

    v_json := v_json || ']';

    RETURN v_json;

EXCEPTION
    WHEN OTHERS THEN
        RETURN '{"erro":"Erro ao gerar lista"}';
END;
/