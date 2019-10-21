import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Andamento extends StatefulWidget {
  @override
  _AndamentoState createState() => _AndamentoState();
}

class _AndamentoState extends State<Andamento> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                        child: const Text('Finalizar'),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> FinalizarChamado()));
                        },
                      ),
                      OutlineButton(
                        child: const Text('Pausar'),
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
        ],
      ),
    );
  }
}
