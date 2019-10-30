import 'package:app_vai/netflix/FilmesEditar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Netflix extends StatefulWidget {
  @override
  _NetflixState createState() => _NetflixState();
}

class _NetflixState extends State<Netflix> {
  DocumentSnapshot dadosBranco;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "netflox",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection("filmes")
                    .orderBy("nomeFilme")
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
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 20),
                          ),
                        );
                      }

                      return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            return Card(
                                // Lista os produtos
                                child: ListTile(
                                  //snapshot.data.documents[index].documentID.toString() - pega o ID
                                  title: Text(
                                  snapshot
                                      .data.documents[index].data["nomeFilme"],
                                  style: TextStyle(fontSize: 25)),
                                  subtitle: Text(
                                  "R\$ " +
                                      snapshot.data.documents[index]
                                          .data["precoFilme"]
                                          .toString(),
                                  style: TextStyle(fontSize: 20)),

                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        color: Colors.black,
                                        onPressed: () {
                                          //  Navigator.push(context, MaterialPageRoute(builder: (context) => FilmesEditar("inc",dadosBranco)));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FilmesEditar(
                                                          "alt",
                                                          snapshot.data
                                                              .documents[index])));
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        color: Colors.black,
                                        onPressed: () {
                                          confirmaExclusao(
                                              context, index, snapshot);
                                        },
                                  ),
                                ],
                              ),
                            ));
                          });
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FilmesEditar("inc", dadosBranco)));
        },
      ),
    );
  }

  confirmaExclusao(BuildContext context, index, snapshot) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Atenção !"),
          content: Text("Confirma a exclusão de : \n" +
              snapshot.data.documents[index].data["nomeFilme"]
                  .toString()
                  .toUpperCase()),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Firestore.instance
                    .collection('filmes')
                    .document(
                        snapshot.data.documents[index].documentID.toString())
                    .delete();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
