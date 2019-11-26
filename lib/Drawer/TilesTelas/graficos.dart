/*qEspera = Firestore.instance.collection("chamados").where("status", isEqualTo: "1").snapshots().toString();
qPausado = Firestore.instance.collection("chamados").snapshots().length.toString();
qAndamento = Firestore.instance.collection("chamados").snapshots().length.toString();
qFinalizado = Firestore.instance.collection("chamados").snapshots().length.toString();*/

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Graficos extends StatefulWidget {
  @override
  _GraficosState createState() => _GraficosState();
}

class _GraficosState extends State<Graficos> {
  @override
  Widget build(BuildContext context) {
    var data = [
      Gra('Em Aberto', 10),
      Gra('Pausados', 25),
      Gra('Andamento', 30),
      Gra('Finalizados', 30),
    ];

    var series = [
      charts.Series(
          domainFn: (Gra sales, _) => sales.year,
          measureFn: (Gra sales, _) => sales.sales,
//          id: 'Sales',
          data: data,
//          colorFn: (T, _) => charts.MaterialPalette.green.shadeDefault,
          labelAccessorFn: (Gra sales, _) => sales.year.toString())
    ];

    var chart = charts.BarChart(
      series,
//      barRendererDecorator: new charts.BarLabelDecorator<String>(),
//      vertical: false,
    );
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            child: chart,
            height: 500,
          ),
          Text(
            "Gráficos",
            style: TextStyle(fontSize: 20, color: Colors.white),
            textAlign: TextAlign.center,

          ),

        ],
      ),
    );
  }
}

class Gra {
  final String year;
  final double sales;

  Gra(this.year, this.sales);
}
