CREATE OR REPLACE PROCEDURE prc_insere_link(
    p_tt_link IN VARCHAR2,
    p_cd_link IN CLOB,
    p_id_trilha_carreira IN INTEGER
) AS
BEGIN
    INSERT INTO T_OR_LINK (tt_link, cd_link, id_trilha_carreira)
    VALUES (p_tt_link, p_cd_link, p_id_trilha_carreira);
    COMMIT;
END;
/


CREATE OR REPLACE PROCEDURE prc_update_link(
    p_id_link IN INTEGER,
    p_tt_link IN VARCHAR2,
    p_cd_link IN CLOB,
    p_id_trilha_carreira IN INTEGER
) AS
BEGIN
    UPDATE T_OR_LINK
       SET tt_link = p_tt_link,
           cd_link = p_cd_link,
           id_trilha_carreira = p_id_trilha_carreira
     WHERE id_link = p_id_link;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20040, 'Link não encontrado para atualização.');
    END IF;

    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE prc_delete_link(
    p_id_link IN INTEGER
) AS
BEGIN
    DELETE FROM T_OR_LINK
     WHERE id_link = p_id_link;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20041, 'Link não encontrado para exclusão.');
    END IF;

    COMMIT;
END;
/
