from mongo_collections.comentario_collection import comentarios


def inserir_comentario():

    comentario = {

        "usuario": input("Usuário: "),
        "comentario": input("Comentário: "),
        "trilha": input("Trilha: "),
        "curtidas": 0,
        "ativo": True,
        "cidade": input("Cidade: "),
        "bairro": input("Bairro: "),
        "tipo_usuario": "COMUM",
        "reportado": False,
        "data_comentario": "2026-05-20"
    }

    comentarios.insert_one(comentario)

    print("\nComentário inserido!")


def listar_comentarios():

    print("\n===== COMENTÁRIOS =====")

    for comentario in comentarios.find():

        print(comentario)


def atualizar_comentario():

    usuario = input("Digite o usuário: ")

    novo_comentario = input("Novo comentário: ")

    comentarios.update_one(
        {"usuario": usuario},
        {"$set": {"comentario": novo_comentario}}
    )

    print("\nComentário atualizado!")


def deletar_comentario():

    usuario = input("Digite o usuário: ")

    comentarios.delete_one(
        {"usuario": usuario}
    )

    print("\nComentário deletado!")


def buscar_comentario():

    usuario = input("Digite o usuário: ")

    comentario = comentarios.find_one(
        {"usuario": usuario}
    )

    if comentario:
        print(comentario)
    else:
        print("\nComentário não encontrado!")
