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

  var _valueTipoChamado;
  var _tipoChamado = ["Incidente", "Melhoria", "Requisição de Serviço"];

  TextEditingController tituloChamado = TextEditingController();
  TextEditingController descricaoChamado = TextEditingController();
  TextEditingController tipoChamado  = TextEditingController();
  TextEditingController classificacao  = TextEditingController();

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _tituloChamado("Título"),
              _sizedBox(15, 15),
              _descricaoChamado("Descrição"),
              _categoriaMenu(),
              _tipoServicoMenu(),
              buttonCamera(),
              buttonBarAbrirCancelar(),
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
      hint: Text("selecione uma categoria"),
      onChanged: (value) {
        setState(() {
          _valueClassificacao = value;
        });
      },
      isExpanded: true,
      value: _valueClassificacao,
      elevation: 2,
      iconSize: 40.0,

    );
  }

  DropdownButton<String> _tipoServicoMenu() {
    return DropdownButton<String>(
      items: _tipoChamado.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
          value: dropDownStringItem,
          child: Text(dropDownStringItem),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _valueTipoChamado = value;
        });
      },
      isExpanded: true,
      hint: Text("Selecione um tipo"),
      value: _valueTipoChamado,
      elevation: 2,
      iconSize: 40.0,
    );
  }

  IconButton buttonCamera() {
    return IconButton(
              icon: Icon(Icons.camera_alt),
              iconSize: 50,
              onPressed: () {
                AlertDialog(content: Text("ainda não carai"));
              },
    );
  }

  ButtonBar buttonBarAbrirCancelar() {
    return ButtonBar(
              children: <Widget>[
                _botaoCancelarChamado(),
                _botaoAbrirChamado(),
              ],
            );
  }

  RaisedButton _botaoAbrirChamado() {
    return RaisedButton(
      child: Text("Concluir"),
      color: Colors.indigo,
      onPressed: () {
        if (formkey.currentState.validate()){
          Firestore.instance.collection("chamados").add({
            "titulo": tituloChamado.text,
            "descricao": descricaoChamado.text,
            "classificacao": _valueClassificacao,
            "tipo": _valueTipoChamado,
            "status": "1",
          });
          Navigator.of(context).pop();
        }
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

  TextFormField _descricaoChamado(String label) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 2,
      maxLines: 10,
      decoration: InputDecoration(
          labelText: label, hintMaxLines: 10, border: OutlineInputBorder()),
      controller: descricaoChamado,
      validator: (value) => value.isEmpty ? "infome a descrição!" :  null
    );
  }

  TextFormField _tituloChamado(String label) {
    return TextFormField(
//      textInputAction: TextInputAction.next,
      decoration:
          InputDecoration(labelText: label, border: OutlineInputBorder()),
      controller: tituloChamado,
      validator: (value) => value.isEmpty ? "infome o título!" :  null,
    );
  }

  SizedBox _sizedBox(double largura, double altura) => SizedBox(
        height: altura,
        width: largura,
      );
}

//cor vermelho abase(169, 36, 37)
//cor azul abase (62, 64, 149)
