import 'package:flutter/material.dart';

class Pausa extends StatefulWidget {
  @override
  _PausaState createState() => _PausaState();
}

class _PausaState extends State<Pausa> {
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
                title: Text('Teclado Estragado'),
                subtitle: Text('Teclado parou de funcionar'),
              ),
              ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    OutlineButton(
                      child: const Text('Retomar'),
                      onPressed: () {/* ... */},
                    ),
                    OutlineButton(
                      child: const Text('Detalhes'),
                      onPressed: () {/* ... */},
                    ),
                    IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {},
                    ),
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
                  child: ButtonBar(children: <Widget>[
                OutlineButton(
                  child: const Text('Retomar'),
                  onPressed: () {/* ... */},
                ),
                OutlineButton(
                  child: const Text('Detalhes'),
                  onPressed: () {/* ... */},
                ),
                IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {},
                ),
              ])),
            ],
          ),
        ),
      ],
    );
  }
}
