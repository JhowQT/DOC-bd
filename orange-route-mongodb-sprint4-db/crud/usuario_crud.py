from mongo_collections.usuario_collection import usuarios


def inserir_usuario():

    usuario = {

        "nome": input("Nome: "),
        "email": input("Email: "),
        "senha": input("Senha: "),
        "telefone": input("Telefone: "),
        "cidade": input("Cidade: "),
        "bairro": input("Bairro: "),
        "ativo": True,
        "tipo_usuario": "COMUM",
        "pontuacao": 0,
        "data_cadastro": "2026-05-20"
    }

    usuarios.insert_one(usuario)

    print("\nUsuário inserido!")


def listar_usuarios():

    print("\n===== USUÁRIOS =====")

    for usuario in usuarios.find():

        print(usuario)


def atualizar_usuario():

    email = input("Digite o email: ")

    novo_nome = input("Novo nome: ")

    usuarios.update_one(
        {"email": email},
        {"$set": {"nome": novo_nome}}
    )

    print("\nUsuário atualizado!")


def deletar_usuario():

    email = input("Digite o email: ")

    usuarios.delete_one(
        {"email": email}
    )

    print("\nUsuário deletado!")


def buscar_usuario():

    email = input("Digite o email: ")

    usuario = usuarios.find_one(
        {"email": email}
    )

    if usuario:
        print(usuario)
    else:
        print("\nUsuário não encontrado!")