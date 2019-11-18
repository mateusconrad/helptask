import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Graficos extends StatefulWidget {
  @override
  _GraficosState createState() => _GraficosState(
  );

}

class _GraficosState extends State<Graficos> {

  @override
  Widget build(BuildContext context) {
//    var qtdeAberto = Firestore.instance
//        .collection("chamados")
//        .where("status", isEqualTo: "1")
//        .orderBy("titulo")
//        .snapshots();
//    for(int i; i< (); i++)
    var data = [
      Gra('em aberto', 5550),
      Gra('Fev', 25000),
      Gra('Mar', 30000),

    ];

    var series = [
      charts.Series(
          domainFn: (Gra sales, _) => sales.year,
          measureFn: (Gra sales, _) => sales.sales,
          id: 'Sales',
          data: data,
          colorFn: (T, _) => charts.MaterialPalette.indigo.shadeDefault,
          labelAccessorFn: (Gra sales, _) =>
          'R\$${sales.sales.toStringAsFixed(2)}')
    ];

    var chart = charts.BarChart(
      series,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      vertical: true,
       behaviors: [

        new charts.DatumLegend(
          showMeasures: false,
          position: charts.BehaviorPosition.bottom,
          //outsideJustification: charts.OutsideJustification.endDrawArea,
          //horizontalFirst: false,
          desiredMaxRows: 7,
          cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
          entryTextStyle: charts.TextStyleSpec(
              color: charts.MaterialPalette.white,
              fontFamily: 'Georgia',
              fontSize: 11,
          ),
        )
      ],
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
          Text(
            "Gráficos",
            style: TextStyle(fontSize: 20, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
//          Container(
//            height: 50,
//            alignment: Alignment.centerLeft,
//            decoration: BoxDecoration(
//              color: Colors.green,
//              borderRadius: BorderRadius.all(
//                Radius.circular(30),
//              ),
//            ),
//            child: SizedBox.expand(
//              child: FlatButton(
//                child: Text(
//                  "Receita bruta por mês",
//                  style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                    color: Colors.white,
//                    fontSize: 16,
//                  ),
//                ),
//                onPressed: () {},
//              ),
//            ),
//          )
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