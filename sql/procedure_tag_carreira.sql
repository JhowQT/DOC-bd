CREATE OR REPLACE PROCEDURE prc_insere_tag_carreira(
    p_id_trilha_carreira IN INTEGER,
    p_id_tag IN INTEGER
) AS
BEGIN
    INSERT INTO T_OR_TAG_CARREIRA (id_trilha_carreira, id_tag)
    VALUES (p_id_trilha_carreira, p_id_tag);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE prc_update_tag_carreira(
    p_id_tag_carreira IN INTEGER,
    p_id_trilha_carreira IN INTEGER,
    p_id_tag IN INTEGER
) AS
BEGIN
    UPDATE T_OR_TAG_CARREIRA
       SET id_trilha_carreira = p_id_trilha_carreira,
           id_tag = p_id_tag
     WHERE id_tag_carreira = p_id_tag_carreira;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20010, 'Tag_Carreira não encontrada para atualização.');
    END IF;

    COMMIT;
END;
/


CREATE OR REPLACE PROCEDURE prc_delete_tag_carreira(
    p_id_tag_carreira IN INTEGER
) AS
BEGIN
    DELETE FROM T_OR_TAG_CARREIRA
     WHERE id_tag_carreira = p_id_tag_carreira;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20011, 'Tag_Carreira não encontrada para exclusão.');
    END IF;

    COMMIT;
END;
/
