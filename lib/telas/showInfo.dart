import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

showInfo(BuildContext context, index, snapshot){
  var resolucao = snapshot.data.documents[index].data["resolucao"].toString();
  var urlImagem = snapshot.data.documents[index].data["urlImagem"].toString();
  var data = snapshot.data.documents[index].data["data"].toString();
  showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(snapshot.data.documents[index].data["titulo"].
          toString().
          toUpperCase()),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Classificação: "+snapshot.data.documents[index].data["classificacao"].toString()),
              Text("Tipo: "+snapshot.data.documents[index].data["tipo"].toString()),
              Text("Descrição: "+snapshot.data.documents[index].data["descricao"].toString()),
              Text("Resolução: "+ resolucao,),
              Text("Resolução: "+ data,),
//              Image.network(urlImagem, width: 150,),
            ],
          ),
        );
      }
  );
}