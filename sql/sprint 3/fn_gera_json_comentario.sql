CREATE OR REPLACE FUNCTION fn_gera_json_comentario(
    p_usuario VARCHAR2,
    p_trilha VARCHAR2,
    p_comentario CLOB
)
RETURN CLOB
AS
    v_json CLOB;
BEGIN

    IF p_usuario IS NULL OR p_trilha IS NULL THEN
        RAISE_APPLICATION_ERROR(-20050, 'Dados inválidos para JSON');
    END IF;

    v_json := '{' ||
              '"usuario": "' || REPLACE(p_usuario, '"', '\"') || '",' ||
              '"trilha": "' || REPLACE(p_trilha, '"', '\"') || '",' ||
              '"comentario": "' || REPLACE(p_comentario, '"', '\"') || '"' ||
              '}';

    RETURN v_json;

EXCEPTION
    WHEN VALUE_ERROR THEN
        RETURN '{"erro":"Erro de conversão"}';
    WHEN ZERO_DIVIDE THEN
        RETURN '{"erro":"Divisão inválida"}';
    WHEN OTHERS THEN
        RETURN '{"erro":"Erro inesperado"}';
END;
/