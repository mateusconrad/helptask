import 'package:flutter/material.dart';

class Finalizado extends StatefulWidget {
  @override
  _FinalizadoState createState() => _FinalizadoState();
}

class _FinalizadoState extends State<Finalizado> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.album),
                title: Text('Gabinete explodiu'),
                subtitle: Text('Aconteceu do nada, resolve aí'),
              ),
              ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    Icon(Icons.info),
                  ],
                ),
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.album),
                title: Text('Teclado Estragado'),
                subtitle: Text('Teclado parou de funcionar'),
              ),
              ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    Icon(Icons.info),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
