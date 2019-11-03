import 'package:app_vai/telas/prioridadeMenu.dart';
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
            ],
          ),
          actions: <Widget>[
//              _prioridadeMenu(),
            //prioridade menu goes here
            PrioridadeMenu(),
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('Atender'),
              onPressed: () {},
            )
          ],
        );
      });
}
