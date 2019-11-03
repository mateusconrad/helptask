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
              Text(snapshot.data.documents[index].data["descricao"].
              toString()),
            ],
          ),
        );
      }
  );
}