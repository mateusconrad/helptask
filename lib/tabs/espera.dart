import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Espera extends StatefulWidget {
  @override
  _EsperaState createState() => _EsperaState();
}

class _EsperaState extends State<Espera> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
            StreamBuilder (
              stream: Firestore.instance
                  .collection("chamados")
                  .snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.done:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (snapshot.data.documents.lenght == 0) {
                      return Center(
                        child: Text(
                          "Não há Chamados",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 20,
                          ),
                        ),
                      );
                    }
                    print('=== data ===: ${snapshot.data}');
                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                              snapshot.data.documents[index].data["titulo"],
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              snapshot.data.documents[index]
                                  .data["descricao"]
                                  .toString()
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                OutlineButton(
                                  child: const Text('Finalizar'),
                                  onPressed: () {
                                    /* ... */
                                  },
                                ),
                                OutlineButton(
                                  child: const Text('Atender'),
                                  onPressed: () {
                                    /* ... */
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.info),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                }
              },
            ),
        ],
      ),
    );
  }
}
