import 'package:flutter/material.dart';

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
                children: <Widget>[
                  Text("Prioridade"),
                  SizedBox(width: 15,),

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
//                Firestore.instance.collection("chamados").add({
//                  "prioridade": ,
//                });
                print(context.widget);

              },
            )
          ],
        );
      });
}

