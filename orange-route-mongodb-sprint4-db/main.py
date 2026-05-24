from crud.usuario_crud import *
from crud.trilha_crud import *
from crud.comentario_crud import *


while True:

    print("\n========== ORANGE ROUTE ==========")

    print("\n===== USUÁRIOS =====")
    print("1 - Inserir usuário")
    print("2 - Listar usuários")
    print("3 - Atualizar usuário")
    print("4 - Deletar usuário")
    print("5 - Buscar usuário")

    print("\n===== TRILHAS =====")
    print("6 - Inserir trilha")
    print("7 - Listar trilhas")
    print("8 - Atualizar trilha")
    print("9 - Deletar trilha")
    print("10 - Buscar trilha")

    print("\n===== COMENTÁRIOS =====")
    print("11 - Inserir comentário")
    print("12 - Listar comentários")
    print("13 - Atualizar comentário")
    print("14 - Deletar comentário")
    print("15 - Buscar comentário")

    print("\n16 - Sair")

    opcao = input("\nEscolha uma opção: ")


    # USUÁRIOS
    if opcao == "1":
        inserir_usuario()

    elif opcao == "2":
        listar_usuarios()

    elif opcao == "3":
        atualizar_usuario()

    elif opcao == "4":
        deletar_usuario()

    elif opcao == "5":
        buscar_usuario()


    # TRILHAS
    elif opcao == "6":
        inserir_trilha()

    elif opcao == "7":
        listar_trilhas()

    elif opcao == "8":
        atualizar_trilha()

    elif opcao == "9":
        deletar_trilha()

    elif opcao == "10":
        buscar_trilha()


    # COMENTÁRIOS
    elif opcao == "11":
        inserir_comentario()

    elif opcao == "12":
        listar_comentarios()

    elif opcao == "13":
        atualizar_comentario()

    elif opcao == "14":
        deletar_comentario()

    elif opcao == "15":
        buscar_comentario()


    elif opcao == "16":
        print("\nSistema encerrado!")
        break

    else:
        print("\nOpção inválida!")