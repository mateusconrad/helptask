import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AbrirChamado extends StatefulWidget {
  final String tipoEdicao;
  final DocumentSnapshot dadosChamado;

  AbrirChamado(this.tipoEdicao, this.dadosChamado);

  @override
  _AbrirChamadoState createState() => _AbrirChamadoState();
}

class _AbrirChamadoState extends State<AbrirChamado> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var _valueClassificacao;
  var _tiposClassificacao = ["Hardware","Software","Rede","Impressoras","Telefonia"];

//  @override
//  void initState() {
//    super.initState();
//
//    tituloChamado.text = widget.dadosChamado.data["titulo"].toString();
//    descricaoChamado.text = widget.dadosChamado.data["descricao"];
//
//  }

  TextEditingController tituloChamado = TextEditingController();
  TextEditingController descricaoChamado = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Abrir Chamado"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _tituloChamado("Título"),
              _sizedBox(15, 15),
              _descricaoChamado("Descrição"),
              Row(
                children: <Widget>[
                  Text("Classificação"),
                  _sizedBox(10, 10),
                  _categoriaMenu(),
                ],
              ),
              IconButton(
                icon: Icon(Icons.camera_alt),
                iconSize: 50,
                onPressed: () {},
              ),
              ButtonBar(
                children: <Widget>[
                  _botaoCancelarChamado(),
                  _botaoAbrirChamado(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownButton<String> _categoriaMenu() {
    return DropdownButton<String>(
      items: _tiposClassificacao.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
          value: dropDownStringItem,
          child: Text(dropDownStringItem),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _valueClassificacao = value;
        });
      },
      value: _valueClassificacao,
      elevation: 2,
      iconSize: 40.0,
    );
  }



  RaisedButton _botaoAbrirChamado() {
    return RaisedButton(
      child: Text("Concluir"),
      color: Colors.indigo,
      onPressed: () {
        Firestore.instance.collection("chamados").add({
          "titulo": tituloChamado.text,
          "descricao": descricaoChamado.text,
          "classificacao": _valueClassificacao,
          "status": "1",
        });

        Navigator.of(context).pop();
      },
    );
  }

  RaisedButton _botaoCancelarChamado() {
    return RaisedButton(
      child: Text("Cancelar"),
      color: Colors.red,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  TextFormField _tituloChamado(String label) {
    return TextFormField(
      decoration:
          InputDecoration(labelText: label, border: OutlineInputBorder()),
      controller: tituloChamado,
      validator: (value) {
        if (value.isEmpty) {
          return "infome o título!";
        }
        return null;
      },
    );
  }

  TextFormField _descricaoChamado(String label) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 2,
      maxLines: 10,
      decoration: InputDecoration(
          labelText: label, hintMaxLines: 10, border: OutlineInputBorder()),
      controller: descricaoChamado,
      validator: (value) {
        if (value.isEmpty) {
          return "infome o título!";
        }
        return null;
      },
    );
  }

  SizedBox _sizedBox(double largura, double altura) => SizedBox(
        height: altura,
        width: largura,
      );
}

//cor vermelho abase(169, 36, 37)
//cor azul abase (62, 64, 149)
