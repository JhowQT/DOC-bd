CREATE OR REPLACE PROCEDURE prc_insere_tag(
    p_nm_tag IN VARCHAR2
) AS
BEGIN
    INSERT INTO T_OR_TAG (nm_tag)
    VALUES (p_nm_tag);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE prc_update_tag(
    p_id_tag IN INTEGER,
    p_nm_tag IN VARCHAR2
) AS
BEGIN
    UPDATE T_OR_TAG
       SET nm_tag = p_nm_tag
     WHERE id_tag = p_id_tag;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Tag não encontrada para atualização.');
    END IF;

    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE prc_delete_tag(
    p_id_tag IN INTEGER
) AS
BEGIN
    DELETE FROM T_OR_TAG
     WHERE id_tag = p_id_tag;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Tag não encontrada para exclusão.');
    END IF;

    COMMIT;
END;
/
