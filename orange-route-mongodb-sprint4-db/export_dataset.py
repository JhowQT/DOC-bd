import json
from bson import ObjectId

from mongo_collections.usuario_collection import usuarios
from mongo_collections.trilha_collection import trilhas
from mongo_collections.comentario_collection import comentarios


# Converter ObjectId para string
class JSONEncoder(json.JSONEncoder):
    def default(self, obj):

        if isinstance(obj, ObjectId):
            return str(obj)

        return json.JSONEncoder.default(self, obj)


# =========================
# EXPORTAR USUÁRIOS
# =========================

usuarios_lista = list(usuarios.find())

with open("dataset/usuarios.json", "w", encoding="utf-8") as arquivo:
    json.dump(usuarios_lista, arquivo, indent=4, ensure_ascii=False, cls=JSONEncoder)

print("usuarios.json exportado!")


# =========================
# EXPORTAR TRILHAS
# =========================

trilhas_lista = list(trilhas.find())

with open("dataset/trilhas.json", "w", encoding="utf-8") as arquivo:
    json.dump(trilhas_lista, arquivo, indent=4, ensure_ascii=False, cls=JSONEncoder)

print("trilhas.json exportado!")


# =========================
# EXPORTAR COMENTÁRIOS
# =========================

comentarios_lista = list(comentarios.find())

with open("dataset/comentarios.json", "w", encoding="utf-8") as arquivo:
    json.dump(comentarios_lista, arquivo, indent=4, ensure_ascii=False, cls=JSONEncoder)

print("comentarios.json exportado!")


print("\nDataset exportado com sucesso!")