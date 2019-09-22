import 'package:flutter/material.dart';



class AbrirChamado extends StatefulWidget {
  @override
  _AbrirChamadoState createState() => _AbrirChamadoState();
}

class _AbrirChamadoState extends State<AbrirChamado> {


  var _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Abrir Chamado"),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 15,),
          _textoChamado("Título"),
          SizedBox(height: 15,),
          _textoDescr("Descrição"),
          _normal2Down(),
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
        hintMaxLines: 10,
          border: OutlineInputBorder(
        )
      ),
    );
  }

  DropdownButton _normal2Down() => DropdownButton<String>(
    items: [
      DropdownMenuItem<String>(
        value: "1", child: Text("Baixa",),),
      DropdownMenuItem<String>(
        value: "2", child: Text("Média",),),
      DropdownMenuItem<String>(
        value: "3", child: Text("Alta",),),
      DropdownMenuItem<String>(
        value: "4", child: Text("Crítica",),),
    ],

    onChanged: (value) {
      setState(() {
        _value = value;
      });
    },
    value: _value,
    elevation: 2,
    //style: TextStyle(color: Colors.black, fontSize: 30),
    //isDense: true,
    iconSize: 40.0,
  );


}
