import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GraficosPage extends StatefulWidget {
  @override
  _GraficosPageState createState() => _GraficosPageState();
}

class _GraficosPageState extends State<GraficosPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Graficus')) ,
      body: birlBodyBuilder(),

//      body: _buildBody(context),
    );
  }

  StreamBuilder<QuerySnapshot> birlBodyBuilder() => StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection("chamados").snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return LinearProgressIndicator();
      } else {
        snapshot.data.documents.length;
        return null;//_buildChart(context, sales);
      }
  }
  );
}


class Chamados {
  final String statusChamados;
  final double qtdeChamados;

  Chamados(this.statusChamados, this.qtdeChamados);
}

/*
* var qtdeEspera = Firestore.instance
      .collection("chamados")
      .where("status", isEqualTo: "1")
      .snapshots()
      .length
      .toString();
  var qtdePausado = Firestore.instance
      .collection("chamados")
      .where("status", isEqualTo: "2")
      .snapshots()
      .length
      .toString();
  var qtdeAndamento = Firestore.instance
      .collection("chamados")
      .where("status", isEqualTo: "3")
      .snapshots()
      .length
      .toString();
  var qtdeFinalizado = Firestore.instance
      .collection("chamados")
      .where("status", isEqualTo: "4")
      .snapshots()
      .length
      .toString();


  Future totalDeChamados() async {
    setState(() {
      super.initState();
      qtdeEspera;
      qtdePausado;
      qtdeAndamento;
      qtdeFinalizado;
    });
  }
* */