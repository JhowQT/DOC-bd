CREATE OR REPLACE FUNCTION fn_json_comentario_por_id(
    p_id_comentario NUMBER
)
RETURN CLOB
AS
    v_usuario VARCHAR2(100);
    v_trilha VARCHAR2(150);
    v_comentario CLOB;
BEGIN

    SELECT 
        u.nm_usuario,
        t.tt_trilha_carreira,
        c.cd_comentario
    INTO 
        v_usuario,
        v_trilha,
        v_comentario
    FROM T_OR_COMENTARIO c
    JOIN T_OR_USUARIO u 
        ON u.id_usuario = c.id_usuario
    JOIN T_OR_TRILHA_CARREIRA t 
        ON t.id_trilha_carreira = c.id_trilha_carreira
    WHERE c.id_comentario = p_id_comentario;

    RETURN fn_gera_json_comentario(
        v_usuario,
        v_trilha,
        v_comentario
    );

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN '{"erro":"Comentario não encontrado"}';
    WHEN OTHERS THEN
        RETURN '{"erro":"Erro ao gerar JSON"}';
END;
/