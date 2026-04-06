CREATE OR REPLACE TYPE tp_rel_comentario_row AS OBJECT (
    nome_usuario       VARCHAR2(100),
    trilha_titulo      VARCHAR2(150),
    conteudo_comentario CLOB,
    ativo              CHAR(1)
);
/

CREATE OR REPLACE TYPE tp_rel_comentario_tab AS TABLE OF tp_rel_comentario_row;
/

CREATE OR REPLACE FUNCTION fn_relatorio_comentarios
RETURN tp_rel_comentario_tab PIPELINED
AS
    CURSOR c_rel IS
        SELECT
            u.nm_usuario,
            t.tt_trilha_carreira,
            c.cd_comentario,
            c.at_comentario
        FROM T_OR_COMENTARIO c
        INNER JOIN T_OR_USUARIO u ON c.id_usuario = u.id_usuario
        INNER JOIN T_OR_TRILHA_CARREIRA t ON c.id_trilha_carreira = t.id_trilha_carreira
        ORDER BY u.nm_usuario, t.tt_trilha_carreira;
BEGIN
    FOR rec IN c_rel LOOP
        PIPE ROW (
            tp_rel_comentario_row(
                rec.nm_usuario,
                rec.tt_trilha_carreira,
                rec.cd_comentario,
                rec.at_comentario
            )
        );
    END LOOP;
    RETURN;
END;
/

SELECT * FROM TABLE(fn_relatorio_comentarios);

