import 'package:app_vai/telas/showInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Espera extends StatefulWidget {
  @override
  _EsperaState createState() => _EsperaState();
}

class _EsperaState extends State<Espera> {

  DocumentSnapshot dadosBranco;

  var _valuePrioridade;
  var _tiposPrioridades = ["Baixa", "Média", "Alta", "Critica"];
  TextEditingController resolucaoChamado  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder(

              stream: Firestore.instance
                  .collection("chamados")
                  .where("status", isEqualTo: "1")
                  .orderBy("titulo")
//                  .orderBy("prioridade", descending: true)
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
                                ListTile(//snapshot.data.documents[index].documentID.toString() -- pega o ID
                                title: Text(
                                    snapshot.data.documents[index].data["titulo"].toString(),
                                    style: TextStyle(fontSize: 25)),
                                ),

//                              Text(snapshot.data),
                                ButtonTheme.bar(
                                child: ButtonBar(
                                  children: <Widget>[
                                    if (FirebaseAuth == EmailAuthProvider) OutlineButton(
                                      child: const Text('Finalizar'),
                                      onPressed: () {
                                        finalizarChamado(context, index, snapshot);
                                      },
                                    ),
                                    if (FirebaseAuth == EmailAuthProvider) OutlineButton(
                                      child: const Text('Atender'),
                                      onPressed: () => atenderChamado(
                                          context,
                                          index,
                                          snapshot),
//                          snapshot.data
//                              .documents[index])
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.info),
                                      onPressed: () =>
                                          showInfo(context, index, snapshot),
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

  atenderChamado(BuildContext context, index, snapshot) {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              //  Firestore.instance.collection("chamados").getDocuments()
                snapshot.data.documents[index].data["titulo"]
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
                    _dropdownPriodade(),
                  ],
                ),
              ],

            ),
            actions: <Widget>[
              //prioridade menu goes here
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),

              FlatButton(
                child: Text('Atender'),
                onPressed: () {
                  snapshot.data.documents[index].data["chamados"].toString();
                  Firestore.instance.collection("chamados").document(
                      snapshot.data.documents[index].documentID.toString())
                      .updateData(
                      {
                        "status": "3",
                        "prioridade":_valuePrioridade,
                      }
                      );
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  finalizarChamado(BuildContext context, index, snapshot) {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              //  Firestore.instance.collection("chamados").getDocuments()
                snapshot.data.documents[index].data["titulo"]
                    .toString()
                    .toUpperCase()),
            content: Column(
              children: <Widget>[
                Text(snapshot.data.documents[index].data["descricao"].toString()),
                _resolucaoChamado("Resolução"),

              ],

            ),
            actions: <Widget>[
              //prioridade menu goes here
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),

              FlatButton(
                child: Text('Concluir'),
                onPressed: () {
                  snapshot.data.documents[index].data["chamados"].toString();
                  Firestore.instance.collection("chamados").document(
                      snapshot.data.documents[index].documentID.toString())
                      .updateData(
                      {
                        "status": "4",
                        "resolucao": resolucaoChamado.text,
                      }
                  );
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  _dropdownPriodade() {
    return DropdownButton<String>(
      items: _tiposPrioridades.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
          value: dropDownStringItem,
          child: Text(dropDownStringItem),
        );
      }).toList(),


      onChanged: (value) {
        setState(() {
          _valuePrioridade = value;
        });
      },

      value: _valuePrioridade,
      elevation: 2,
      //style: TextStyle(color: Colors.black, fontSize: 30),
      //isDense: true,
      iconSize: 40.0,
    );
  }
  _resolucaoChamado(String label) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 2,
      maxLines: 10,
      decoration: InputDecoration(
          labelText: label, hintMaxLines: 10, border: OutlineInputBorder()),
      controller: resolucaoChamado,
      validator: (value) {
        if (value.isEmpty) {
          return "infome o título!";
        }
        return null;
      },
    );
  }

}
