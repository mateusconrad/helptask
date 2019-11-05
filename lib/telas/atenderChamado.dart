import 'package:app_vai/telas/prioridadeMenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'abrir_chamado.dart';
atenderChamado(BuildContext context, index, snapshot) {
  showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(snapshot.data.documents[index].data["titulo"]
              .toString()
              .toUpperCase()),
          content: Column(
            children: <Widget>[
              Text(snapshot.data.documents[index].data["descricao"].toString()),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text("Prioridade"),
                  SizedBox(width: 15,),
                  PrioridadeMenu(),
                ],
              ),
            ],

          ),
          actions: <Widget>[
//              _prioridadeMenu(),
            //prioridade menu goes here
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('Atender'),
              onPressed: () {
                Firestore.instance.collection("chamados")
                    .document(context.widget.toString())
                    .updateData(
                    {
                      "status": "3",
                    }
                );
//
//
                print(context.widget);

              },
            )
          ],
        );
      });
}

