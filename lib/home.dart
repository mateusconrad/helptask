import 'package:app_vai/drawer/menuLateral.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String nomeTab = "Chamados";
  DocumentSnapshot dadosBranco;

  List<Filtro> filtros = List();


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
          text: ("em espera"),
        ),
        Tab(
          icon: Icon(Icons.pause),
          text: ("pausados"),
        ),
        Tab(
          icon: Icon(Icons.build),
          text: ("atendendo"),
        ),
        Tab(
          icon: Icon(Icons.check),
          text: ("finalizados"),
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
        //      Navigator.push(context, MaterialPageRoute(builder: (context)=> Netflix   ()));
      },
    );
  }


}

//        userDetails: details);

class Filtro {
  String nome;
  int idade;

  Filtro(this.nome, this.idade);
}
