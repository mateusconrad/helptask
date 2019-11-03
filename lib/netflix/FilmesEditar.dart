import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FilmesEditar extends StatefulWidget {

  final String tipoEdicao;
  final DocumentSnapshot dadosFilme;

  FilmesEditar(this.tipoEdicao, this.dadosFilme);


  @override
  _FilmesEditarState createState() => _FilmesEditarState();
}

class _FilmesEditarState extends State<FilmesEditar> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.tipoEdicao=="alt"){
      nomeFilme.text =widget.dadosFilme.data["nomeFilme"].toString();
      precoFilme.text =widget.dadosFilme.data["precoFilme"].toString();
      idGenero.text =widget.dadosFilme.data["idGenero"].toString();
    }
  }

  TextEditingController nomeFilme = TextEditingController();
  TextEditingController precoFilme = TextEditingController();
  TextEditingController idGenero = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        title: Text("Edição de filmes"),
          title: Text(widget.tipoEdicao=="inc" ? "Inclusao de Filmes" : "Alteração de Filmes"), //if ternário
//           shape: ShapeBorder(),
        ),

      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, right: 10, top: 15),
        child: Form(
          key: formkey,
          child: Column(

            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "Nome Filme", border: OutlineInputBorder()),
                controller: nomeFilme,
                validator: (value){
                  if(value.isEmpty){
                    return "infome o nome do filme";
                  }return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Preço Filme", border: OutlineInputBorder()),
                controller: precoFilme,
                validator: (value){
                  if(value.isEmpty){
                    return "Infome o preço do filme";
                  }return null;
                },
              ),
              TextFormField(
                controller: idGenero,
                decoration: InputDecoration(labelText: "Gênero Filme", border: OutlineInputBorder()),
                validator: (value){
                  if(value.isEmpty){
                    return "infome o Gênero do filme";
                  }return null;
                },
              ),

              RaisedButton(
                child: Text("gravar"),
                onPressed: () {
                if (widget.tipoEdicao=="inc"){
                  Firestore.instance.collection("filmes").add({
                    "nomeFilme": nomeFilme.text,
                    "precoFilme": precoFilme.text,
                    "generoFilme": idGenero.text,
                  });
                  Navigator.pop(context);
                }else{
                  Firestore.instance.collection("filmes")
                      .document(widget.dadosFilme.documentID)
                      .updateData(
                        {
                          "nomeFilme": nomeFilme.text,
                          "precoFilme": precoFilme.text,
                          "generoFilme": idGenero.text,
                        }
                      );
                  Navigator.pop(context);
                }
                }
              )
            ],
          ),
        ),
      ),

    );
  }
}
