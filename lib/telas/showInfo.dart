//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

showInfo(BuildContext context, index, snapshot) {
  var resolucao = snapshot.data.documents[index].data["resolucao"].toString();
  var urlImagem = snapshot.data.documents[index].data["urlImagem"];
  var data = snapshot.data.documents[index].data["dataAbertura"].toString();
  var hora = snapshot.data.documents[index].data["horaAbertura"].toString();
  print(urlImagem);

  showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(snapshot.data.documents[index].data["titulo"]
              .toString()
              .toUpperCase()),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Classificação: " +
                    snapshot.data.documents[index].data["classificacao"]
                        .toString()),
                Divider(),
                Text("Tipo: " +
                    snapshot.data.documents[index].data["tipo"].toString()),
                Divider(),
                Text("Descrição: " +
                    snapshot.data.documents[index].data["descricao"]
                        .toString()),
                Divider(),
                Text("Abertura: " + data + " " + hora),
                Divider(),
                Text(
                  "Resolução: " + resolucao,
                ),
                Divider(),
                if (urlImagem != null ) Container(
                  child: Image.network(
                    urlImagem,
                    width: 150,
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
