CREATE OR REPLACE FUNCTION fn_score_trilha(
    p_id_trilha NUMBER
)
RETURN NUMBER
AS
    v_comentarios NUMBER;
    v_favoritos NUMBER;
BEGIN

    SELECT COUNT(*) INTO v_comentarios
    FROM T_OR_COMENTARIO
    WHERE id_trilha_carreira = p_id_trilha;

    SELECT COUNT(*) INTO v_favoritos
    FROM T_OR_FAVORITO
    WHERE id_trilha_carreira = p_id_trilha;

    RETURN (v_comentarios * 2) + (v_favoritos * 3);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN VALUE_ERROR THEN
        RETURN -1;
    WHEN OTHERS THEN
        RETURN -999;
END;
/