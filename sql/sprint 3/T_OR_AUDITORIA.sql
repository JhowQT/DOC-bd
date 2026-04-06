CREATE TABLE T_OR_AUDITORIA (
    id_auditoria NUMBER GENERATED ALWAYS AS IDENTITY,
    tabela VARCHAR2(50),
    operacao VARCHAR2(10),
    usuario VARCHAR2(50),
    data_operacao DATE,
    dados_antigos CLOB,
    dados_novos CLOB
);