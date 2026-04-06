CREATE TABLE T_OR_TIPO_USUARIO (
    id_tipo_usuario INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nm_tipo_usuario VARCHAR2(50) NOT NULL
);

CREATE TABLE T_OR_USUARIO (
    id_usuario INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nm_usuario VARCHAR2(100) NOT NULL,
    email VARCHAR2(150) NOT NULL UNIQUE,
    senha VARCHAR2(150) NOT NULL,
    foto BLOB,
    at_usuario CHAR(1) CHECK (at_usuario IN ('0','1')),
    id_tipo_usuario INTEGER NOT NULL,
    CONSTRAINT fk_usuario_tipo FOREIGN KEY (id_tipo_usuario)
        REFERENCES T_OR_TIPO_USUARIO (id_tipo_usuario)
);

CREATE TABLE T_OR_TRILHA_CARREIRA (
    id_trilha_carreira INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tt_trilha_carreira VARCHAR2(150) NOT NULL,
    cd_trilha_carreira CLOB
);

CREATE TABLE T_OR_TAG (
    id_tag INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nm_tag VARCHAR2(100) NOT NULL
);

CREATE TABLE T_OR_COMENTARIO (
    id_comentario INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cd_comentario CLOB NOT NULL,
    at_comentario CHAR(1) CHECK (at_comentario IN ('0','1')),
    id_usuario INTEGER NOT NULL,
    id_trilha_carreira INTEGER NOT NULL,
    CONSTRAINT fk_comentario_usuario FOREIGN KEY (id_usuario)
        REFERENCES T_OR_USUARIO (id_usuario),
    CONSTRAINT fk_comentario_trilha FOREIGN KEY (id_trilha_carreira)
        REFERENCES T_OR_TRILHA_CARREIRA (id_trilha_carreira)
);

CREATE TABLE T_OR_FAVORITO (
    id_favorito INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    id_trilha_carreira INTEGER NOT NULL,
    CONSTRAINT fk_favorito_usuario FOREIGN KEY (id_usuario)
        REFERENCES T_OR_USUARIO (id_usuario),
    CONSTRAINT fk_favorito_trilha FOREIGN KEY (id_trilha_carreira)
        REFERENCES T_OR_TRILHA_CARREIRA (id_trilha_carreira)
);

CREATE TABLE T_OR_TAG_CARREIRA (
    id_tag_carreira INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_trilha_carreira INTEGER NOT NULL,
    id_tag INTEGER NOT NULL,
    CONSTRAINT fk_tagcarreira_trilha FOREIGN KEY (id_trilha_carreira)
        REFERENCES T_OR_TRILHA_CARREIRA (id_trilha_carreira),
    CONSTRAINT fk_tagcarreira_tag FOREIGN KEY (id_tag)
        REFERENCES T_OR_TAG (id_tag)
);

CREATE TABLE T_OR_LINK (
    id_link INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tt_link VARCHAR2(150) NOT NULL,
    cd_link CLOB,
    id_trilha_carreira INTEGER NOT NULL,
    CONSTRAINT fk_link_trilha FOREIGN KEY (id_trilha_carreira)
        REFERENCES T_OR_TRILHA_CARREIRA (id_trilha_carreira)
);