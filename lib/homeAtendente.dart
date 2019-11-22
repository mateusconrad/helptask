import 'package:app_vai/drawer/menuLateral.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'tabs/espera.dart';
import 'tabs/pausados.dart';
import 'tabs/andamento.dart';
import 'tabs/finalizado.dart';
import 'package:app_vai/telas/abrir_chamado.dart';

class TabBarHome extends StatefulWidget {
  @override
  _TabBarHomeState createState() => _TabBarHomeState();
}

class _TabBarHomeState extends State<TabBarHome> {
  String nomeTab = "Help Task";
  DocumentSnapshot dadosBranco;
  TextStyle estilo = TextStyle(fontSize: 12);

  // ignore: non_constant_identifier_names
  int ResultadoGlobal = 0;
  Firestore queryFiltro = new Firestore();
  @override
  void initState() {
    super.initState();
    buildTabBar();

  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //showSemanticsDebugger: true,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),

      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: buildTabBar(),
            title: Text(nomeTab),
            centerTitle: true,
            actions: <Widget>[
              _filtroPopup(),
            ],
          ),
          body: TabBarView(
            physics: FixedExtentScrollPhysics(),
            children: [
              Espera(),
              Pausa(),
              Andamento(),
              Finalizado(),
            ],
          ),
          floatingActionButton: _addChamado(context),
          drawer: MenuLateral(),
        ),
      ),
    );
  }

  PopupMenuButton<int> _filtroPopup() {
    return PopupMenuButton<int>(
      itemBuilder: (context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          child: Text("Titulo A-Z"),
          value: 1,
        ),
        PopupMenuItem<int>(
          child: Text("Titulo Z-A"),
          value: 2,
        ),
        PopupMenuItem<int>(
          child: Text("Data Asc"),
          value: 3,
        ),
        PopupMenuItem<int>(
          child: Text("Data Desc"),
          value: 4,
        ),
        PopupMenuItem<int>(
          child: Text("Prioridade Alta"),
          value: 5,
        ),
        PopupMenuItem<int>(
          child: Text("Prioridade Baixa"),
          value: 6,
        ),
      ],
      onSelected: switchCaseMenuItem,
    );
  }

  void switchCaseMenuItem(int resultado) {
      setState(() {
        switch (resultado) {
          case 1:
            queryFiltro
                .collection("chamados")
                .orderBy("titulo", descending: false).toString();
            break;
          case 2:
            queryFiltro
                .collection("chamados")
                .orderBy("titulo", descending: true).toString();
            break;
          case 3:
            queryFiltro
                .collection("chamados")
                .orderBy("data", descending: false).toString();
            break;
          case 4:
            queryFiltro
                .collection("chamados")
                .orderBy("data", descending: true).toString();
            break;
          case 5:
            queryFiltro
                .collection("chamados")
                .orderBy("prioridade", descending: false).toString();
            break;
          case 6:
            queryFiltro
                .collection("chamados")
                .orderBy("data", descending: true).toString();
            break;
        }
        ResultadoGlobal = resultado;
      });
    }

  TabBar buildTabBar() {
    return TabBar(
      tabs: [
        Tab(
          icon: Icon(Icons.hourglass_full),
          child: Text(
            "Em espera",
            style: estilo,
          ),
        ),
        Tab(
          icon: Icon(Icons.pause),
          child: Text(
            "Pausados",
            style: estilo,
          ),
        ),
        Tab(
          icon: Icon(Icons.build),
          child: Text(
            "Atendendo",
            style: estilo,
          ),
        ),
        Tab(
          icon: Icon(Icons.check),
          child: Text(
            "Finalizados",
            style: estilo,
          ),
        ),
      ],
    );
  }

  FloatingActionButton _addChamado(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text("Novo"),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AbrirChamado("inc", dadosBranco)));
      },
    );
  }
}

//        userDetails: details);
