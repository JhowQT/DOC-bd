from mongo_collections.usuario_collection import usuarios
from mongo_collections.trilha_collection import trilhas
from mongo_collections.comentario_collection import comentarios

# LIMPAR COLLECTIONS
usuarios.delete_many({})
trilhas.delete_many({})
comentarios.delete_many({})

print("Collections limpas!")

# =========================
# USUÁRIOS
# =========================

usuarios.insert_many([

    {
        "nome": "João Silva",
        "email": "joao@gmail.com",
        "senha": "123456",
        "telefone": "11999990001",
        "cidade": "São Paulo",
        "bairro": "Centro",
        "ativo": True,
        "tipo_usuario": "COMUM",
        "pontuacao": 150,
        "data_cadastro": "2026-05-20"
    },

    {
        "nome": "Maria Souza",
        "email": "maria@gmail.com",
        "senha": "123456",
        "telefone": "11999990002",
        "cidade": "Osasco",
        "bairro": "Vila Yara",
        "ativo": True,
        "tipo_usuario": "ADMIN",
        "pontuacao": 300,
        "data_cadastro": "2026-05-20"
    },

    {
        "nome": "Carlos Lima",
        "email": "carlos@gmail.com",
        "senha": "123456",
        "telefone": "11999990003",
        "cidade": "Barueri",
        "bairro": "Alphaville",
        "ativo": True,
        "tipo_usuario": "COMUM",
        "pontuacao": 90,
        "data_cadastro": "2026-05-20"
    },

    {
        "nome": "Ana Costa",
        "email": "ana@gmail.com",
        "senha": "123456",
        "telefone": "11999990004",
        "cidade": "Santos",
        "bairro": "Boqueirão",
        "ativo": True,
        "tipo_usuario": "MODERADOR",
        "pontuacao": 450,
        "data_cadastro": "2026-05-20"
    }

])

print("Usuários inseridos!")

# =========================
# TRILHAS
# =========================

trilhas.insert_many([

    {
        "titulo": "Java Básico",
        "descricao": "Curso introdutório Java",
        "categoria": "Backend",
        "nivel": "Iniciante",
        "duracao": "10h",
        "autor": "João Silva",
        "ativo": True,
        "likes": 120,
        "visualizacoes": 1000,
        "data_criacao": "2026-05-20"
    },

    {
        "titulo": "MongoDB para Iniciantes",
        "descricao": "VIDEO SPRINT 3 FEITO EM MONGO",
        "categoria": "Banco de Dados",
        "nivel": "Intermediário",
        "duracao": "8h",
        "autor": "Maria Souza",
        "ativo": True,
        "likes": 200,
        "visualizacoes": 2300,
        "data_criacao": "2026-05-20"
    },

    {
        "titulo": "Python CRUD",
        "descricao": "CRUD completo em Python",
        "categoria": "Python",
        "nivel": "Avançado",
        "duracao": "15h",
        "autor": "Ana Costa",
        "ativo": True,
        "likes": 340,
        "visualizacoes": 5000,
        "data_criacao": "2026-05-20"
    }

])

print("Trilhas inseridas!")

# =========================
# COMENTÁRIOS
# =========================

comentarios.insert_many([

    {
        "usuario": "João Silva",
        "comentario": "Excelente trilha!",
        "trilha": "Java Básico",
        "curtidas": 10,
        "ativo": True,
        "cidade": "São Paulo",
        "bairro": "Centro",
        "tipo_usuario": "COMUM",
        "reportado": False,
        "data_comentario": "2026-05-20"
    },

    {
        "usuario": "Maria Souza",
        "comentario": "TESTE MONGO!",
        "trilha": "MongoDB para Iniciantes",
        "curtidas": 25,
        "ativo": True,
        "cidade": "Osasco",
        "bairro": "Vila Yara",
        "tipo_usuario": "ADMIN",
        "reportado": False,
        "data_comentario": "2026-05-20"
    },

    {
        "usuario": "Carlos Lima",
        "comentario": "Aprendi bastante.",
        "trilha": "Python CRUD",
        "curtidas": 15,
        "ativo": True,
        "cidade": "Barueri",
        "bairro": "Alphaville",
        "tipo_usuario": "COMUM",
        "reportado": False,
        "data_comentario": "2026-05-20"
    }

])

print("Comentários inseridos!")

print("\nBanco populado com sucesso!")


# mongodb://localhost:27017