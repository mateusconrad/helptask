import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Graficos extends StatefulWidget {
  @override
  _GraficosState createState() => _GraficosState();
}

class _GraficosState extends State<Graficos> {
  @override
  Widget build(BuildContext context) {


    Future<int> espera = Firestore.instance
        .collection("chamados")
        .where("status", isEqualTo: "1")
        .snapshots()
        .length;
    /*
    var pausado = Firestore.instance
        .collection("chamados")
        .where("status", isEqualTo: "2")
        .snapshots()
        .length
        .toString();
    var andamento = Firestore.instance
        .collection("chamados")
        .where("status", isEqualTo: "3")
        .snapshots()
        .length
        .toString();
    var finalizado = Firestore.instance
        .collection("chamados")
        .where("status", isEqualTo: "4")
        .snapshots()
        .length
        .toString();
    var data = [
      Chamados(espera),
      Chamados(pausado),
      Chamados(andamento),
      Chamados(finalizado),

    * */
    var data = [
      Gra('Jan', 2225),
      Gra('Fev', 25000),
      Gra('Mar', 30000),
      Gra('Abr', 8500),
    ];
    var series = [
      charts.Series(
          domainFn: (Gra sales, _) => sales.year,
          measureFn: (Gra sales, _) => sales.sales,
          id: 'Sales',
          data: data,
          colorFn: (T, _) => charts.MaterialPalette.green.shadeDefault,
          labelAccessorFn: (Gra sales, _) => 'R\$${sales.sales.toStringAsFixed(2)}')
    ];
    var chart = charts.BarChart(
      series,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      vertical: false,
      animate: true,
      animationDuration: Duration(seconds: 1),
    );
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            child: chart,
            height: 500,
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

