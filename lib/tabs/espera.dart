import 'package:app_vai/widgets/showInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Espera extends StatefulWidget {
  @override
  _EsperaState createState() => _EsperaState();
}

class _EsperaState extends State<Espera> {
  DocumentSnapshot dadosBranco;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection("chamados")
                  .orderBy("titulo")
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
                    if (snapshot.data.documents.length == 0) {
                      return Center(
                        child: Text(
                          "Não há dados!",
                          style:
                              TextStyle(color: Colors.redAccent, fontSize: 20),
                        ),
                      );
                    }

                    return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        padding: EdgeInsets.only(
                            top: 5, left: 5, right: 5, bottom: 10),
                        itemBuilder: (context, index) {
                          return Card(
                              child: Column(
                            children: <Widget>[
                              ListTile(
                                //snapshot.data.documents[index].documentID.toString()
                                // - pega o ID
                                title: Text(
                                    snapshot
                                        .data.documents[index].data["titulo"],
                                    style: TextStyle(fontSize: 25)),
//                                subtitle: Text(snapshot
//                                    .data.documents[index].data["descricao"]
//                                    .toString()),
                              ),
                              ButtonTheme.bar(
                                child: ButtonBar(
                                  children: <Widget>[
                                    OutlineButton(
                                      child: const Text('Finalizar'),
                                      onPressed: () {},
                                    ),
                                    OutlineButton(
                                      child: const Text('Atender'),
                                      onPressed: () {/* ... */},
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.info),
                                        onPressed: () => showInfo(context, index, snapshot),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ));
                        });
                }
              }),
        ),
      ],
    );
  }
}
