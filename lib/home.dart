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

//  var _valueFiltro;
//  var _tiposFiltro = ["Titulo A-Z", "Titulo Z-A", "Data Asc", "Data Desc", "Prioridade Alta", "Prioridade Baixa"];




  Widget _simplePopup() => PopupMenuButton<int>(
    itemBuilder: (context) => [
      PopupMenuItem(
        value: 1,
        child: Text("Titulo A-Z"),
      ),
      PopupMenuItem(
        value: 2,
        child: Text("Titulo Z-A"),
      ),
      PopupMenuItem(
        value: 3,
        child: Text("Data Asc"),
      ),
      PopupMenuItem(
        value: 4,
        child: Text("Data Desc"),
      ),
      PopupMenuItem(
        value: 5,
        child: Text("Prioridade Alta"),
      ),
      PopupMenuItem(
        value: 6,
        child: Text( "Prioridade Baixa"),
      ),
    ],
  );
//  PopupMenuButton<String> _filtroMenu(){
//    return PopupMenuButton<String>(
//       offset: _tiposFiltro.map((String popUpStringItem){
//        return PopupMenuItem<String>(
//          value:  popUpStringItem,
//          child:  Text(popUpStringItem),
//        );
//      }).toList(),
//    )
//  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //showSemanticsDebugger: true,
      theme: ThemeData(
        brightness: Brightness.light,
      ),

      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: buildTabBar(),
            title: Text(nomeTab),
            centerTitle: true,
            actions: <Widget>[
              FlatButton(
                child: Icon(Icons.filter_list),
                onPressed:(){
                  _simplePopup();
                },
              ),
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
