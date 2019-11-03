import 'package:flutter/material.dart';

class PrioridadeMenu extends StatefulWidget {

  @override
  _PrioridadeMenuState createState() => _PrioridadeMenuState();
}

class _PrioridadeMenuState extends State<PrioridadeMenu> {

  var _valuePrioridade;
  var _tiposPrioridades = ["Baixa", "Média", "Alta", "Critica"];

  @override
  Widget build(BuildContext context) {
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

}
