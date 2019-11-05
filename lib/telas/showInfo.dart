import 'package:flutter/material.dart';

showInfo(BuildContext context, index, snapshot){
  showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(snapshot.data.documents[index].data["titulo"].
          toString().
          toUpperCase()),
          content: Column(
            children: <Widget>[
              Text("Classificação: "+snapshot.data.documents[index].data["classificacao"].toString()),
              Text("Tipo: "+snapshot.data.documents[index].data["tipo"].toString()),
              Text("Descrição: \n"+snapshot.data.documents[index].data["descricao"].toString()),

            ],
          ),
        );
      }
  );
}