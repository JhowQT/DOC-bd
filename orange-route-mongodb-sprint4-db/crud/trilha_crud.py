from mongo_collections.trilha_collection import trilhas


def inserir_trilha():

    trilha = {

        "titulo": input("Título: "),
        "descricao": input("Descrição: "),
        "categoria": input("Categoria: "),
        "nivel": input("Nível: "),
        "duracao": input("Duração: "),
        "autor": input("Autor: "),
        "ativo": True,
        "likes": 0,
        "visualizacoes": 0,
        "data_criacao": "2026-05-20"
    }

    trilhas.insert_one(trilha)

    print("\nTrilha inserida!")


def listar_trilhas():

    print("\n===== TRILHAS =====")

    for trilha in trilhas.find():

        print(trilha)


def atualizar_trilha():

    titulo = input("Digite o título da trilha: ")

    nova_descricao = input("Nova descrição: ")

    trilhas.update_one(
        {"titulo": titulo},
        {"$set": {"descricao": nova_descricao}}
    )

    print("\nTrilha atualizada!")


def deletar_trilha():

    titulo = input("Digite o título da trilha: ")

    trilhas.delete_one(
        {"titulo": titulo}
    )

    print("\nTrilha deletada!")


def buscar_trilha():

    titulo = input("Digite o título da trilha: ")

    trilha = trilhas.find_one(
        {"titulo": titulo}
    )

    if trilha:
        print(trilha)
    else:
        print("\nTrilha não encontrada!")