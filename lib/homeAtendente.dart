import 'package:app_vai/Drawer/drawerAtendente/menuLateral.dart';
import 'package:app_vai/tabs/atendente/andamento.dart';
import 'package:app_vai/tabs/atendente/espera.dart';
import 'package:app_vai/tabs/atendente/finalizado.dart';
import 'package:app_vai/tabs/atendente/pausados.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_vai/telas/abrir_chamado.dart';

class TabBarHomeAtendente extends StatefulWidget {
  @override
  _TabBarHomeAtendenteState createState() => _TabBarHomeAtendenteState();
}

class _TabBarHomeAtendenteState extends State<TabBarHomeAtendente> {
  String nomeTab = "Help Task";
  DocumentSnapshot dadosBranco;
  TextStyle estilo = TextStyle(fontSize: 12);


  @override
  void initState() {
    super.initState();
    buildTabBar();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          drawer: MenuLateralAtendente(),
        ),
      ),
    );
  }

  PopupMenuButton<int> _filtroPopup() {
    return PopupMenuButton<int>(
      itemBuilder: (context) =>
      <PopupMenuEntry<int>>[
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
      onSelected: (int resultado) {
        setState(() {
          switch (resultado) {
            case 1:
              Firestore.instance.collection("chamados").orderBy(
                  "titulo", descending: false);
              break;
            case 2:
              Firestore.instance.collection("chamados").orderBy(
                  "titulo", descending: true);
              break;
            case 3:
              Firestore.instance.collection("chamados").orderBy(
                  "data", descending: false);
              break;
            case 4:
              Firestore.instance.collection("chamados").orderBy(
                  "data", descending: true);
              break;
            case 5:
              Firestore.instance.collection("chamados").orderBy(
                  "prioridade", descending: false);
              break;
            case 6:
              Firestore.instance.collection("chamados").orderBy(
                  "prioridade", descending: true);
              break;
          }
        });
      },
    );
  }

  TabBar buildTabBar() {
    return TabBar(
      tabs: [
        Tab(
          icon: Icon(Icons.hourglass_full),
          child: Text("Em espera", style: estilo,),
        ),
        Tab(
          icon: Icon(Icons.pause),
          child: Text("Pausados", style: estilo,),
        ),
        Tab(
          icon: Icon(Icons.build),
          child: Text("Atendendo", style: estilo,),
        ),
        Tab(
          icon: Icon(Icons.check),
          child: Text("Finalizados", style: estilo,),
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
