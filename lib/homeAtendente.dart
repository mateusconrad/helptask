import 'package:app_vai/drawer/menuLateral.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
              if (EmailAuthProvider != null) Pausa(),
              if (EmailAuthProvider != null) Andamento(),
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
          }
//                      }
//                      if (resultado == 1) {
//                        Firestore.instance.collection("chamados").orderBy("titulo", descending: false);
//                        //filtros.sort((a, b) {return a.nome.toLowerCase().compareTo(b.nome.toLowerCase());});
//                      } else if (resultado == 2) {
//
//                      }
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
