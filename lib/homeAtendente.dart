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
