CREATE OR REPLACE TYPE tp_rel_pop_row AS OBJECT (
    trilha_titulo     VARCHAR2(150),
    qtd_comentarios   NUMBER,
    qtd_favoritos     NUMBER,
    total_interacoes  NUMBER
);
/

CREATE OR REPLACE TYPE tp_rel_pop_tab AS TABLE OF tp_rel_pop_row;
/

CREATE OR REPLACE FUNCTION fn_relatorio_popularidade
RETURN tp_rel_pop_tab PIPELINED
AS
    CURSOR c_pop IS
        SELECT
            t.tt_trilha_carreira AS trilha,
            COUNT(DISTINCT c.id_comentario) AS comentarios,
            COUNT(DISTINCT f.id_favorito) AS favoritos,
            COUNT(DISTINCT c.id_comentario) + COUNT(DISTINCT f.id_favorito) AS total
        FROM T_OR_TRILHA_CARREIRA t
        LEFT JOIN T_OR_COMENTARIO c ON t.id_trilha_carreira = c.id_trilha_carreira
        LEFT JOIN T_OR_FAVORITO f ON t.id_trilha_carreira = f.id_trilha_carreira
        GROUP BY t.tt_trilha_carreira
        ORDER BY total DESC;
BEGIN
    FOR rec IN c_pop LOOP
        PIPE ROW (
            tp_rel_pop_row(
                rec.trilha,
                rec.comentarios,
                rec.favoritos,
                rec.total
            )
        );
    END LOOP;
    RETURN;
END;
/

SELECT * FROM TABLE(fn_relatorio_popularidade);
