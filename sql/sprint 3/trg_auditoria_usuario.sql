CREATE OR REPLACE TRIGGER trg_auditoria_usuario
AFTER INSERT OR UPDATE OR DELETE ON T_OR_USUARIO
FOR EACH ROW
BEGIN

    IF INSERTING THEN
        INSERT INTO T_OR_AUDITORIA (
            tabela, operacao, usuario, data_operacao, dados_novos
        ) VALUES (
            'T_OR_USUARIO',
            'INSERT',
            USER,
            SYSDATE,
            'ID=' || :NEW.id_usuario || 
            ', NOME=' || :NEW.nm_usuario || 
            ', EMAIL=' || :NEW.email
        );

    ELSIF UPDATING THEN
        INSERT INTO T_OR_AUDITORIA (
            tabela, operacao, usuario, data_operacao, dados_antigos, dados_novos
        ) VALUES (
            'T_OR_USUARIO',
            'UPDATE',
            USER,
            SYSDATE,
            'OLD EMAIL=' || :OLD.email,
            'NEW EMAIL=' || :NEW.email
        );

    ELSIF DELETING THEN
        INSERT INTO T_OR_AUDITORIA (
            tabela, operacao, usuario, data_operacao, dados_antigos
        ) VALUES (
            'T_OR_USUARIO',
            'DELETE',
            USER,
            SYSDATE,
            'REMOVIDO ID=' || :OLD.id_usuario || 
            ', EMAIL=' || :OLD.email
        );

    END IF;

END;
/