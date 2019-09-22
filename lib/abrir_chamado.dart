import 'package:flutter/material.dart';



class AbrirChamado extends StatefulWidget {
  @override
  _AbrirChamadoState createState() => _AbrirChamadoState();
}

class _AbrirChamadoState extends State<AbrirChamado> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Abrir Chamado"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 15,),
          _textoChamado("Título"),
          SizedBox(height: 15,),
          _textoDescr("Descrição"),
          Row(
            children: <Widget>[

            ],
          )
        ],
      ),

    );
  }


  TextFormField _textoChamado(String label) {
    return TextFormField(
          decoration: InputDecoration(
            labelText: label,
              border: OutlineInputBorder(

              )
          ),
        );
  }
  TextField _textoDescr(String label) {
    return TextField(
      keyboardType: TextInputType.multiline,
      minLines: 2,
      maxLines: 10,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(

        )
      ),
    );
  }
}
