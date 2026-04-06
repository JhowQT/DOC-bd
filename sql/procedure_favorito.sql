CREATE OR REPLACE PROCEDURE prc_insere_favorito(
    p_id_usuario IN INTEGER,
    p_id_trilha_carreira IN INTEGER
) AS
BEGIN
    INSERT INTO T_OR_FAVORITO (id_usuario, id_trilha_carreira)
    VALUES (p_id_usuario, p_id_trilha_carreira);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE prc_update_favorito(
    p_id_favorito IN INTEGER,
    p_id_usuario IN INTEGER,
    p_id_trilha_carreira IN INTEGER
) AS
BEGIN
    UPDATE T_OR_FAVORITO
       SET id_usuario = p_id_usuario,
           id_trilha_carreira = p_id_trilha_carreira
     WHERE id_favorito = p_id_favorito;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20030, 'Favorito não encontrado para atualização.');
    END IF;

    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE prc_delete_favorito(
    p_id_favorito IN INTEGER
) AS
BEGIN
    DELETE FROM T_OR_FAVORITO
     WHERE id_favorito = p_id_favorito;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20031, 'Favorito não encontrado para exclusão.');
    END IF;

    COMMIT;
END;
/
