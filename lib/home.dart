import 'package:app_vai/login.dart';
import 'package:app_vai/telas/menuLateral.dart';
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
  String nomeTab = "Chamados";

  DocumentSnapshot dadosBranco;



  @override

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
            bottom: TabBar(
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
                  text: ("Finalizados"),
                ),
              ],
            ),
            title: Text(nomeTab),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              Espera(),
              Pausa(),
              Andamento(),
              Finalizado(),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.add),
            label: Text("Novo"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AbrirChamado("inc", dadosBranco)));
              //      Navigator.push(context, MaterialPageRoute(builder: (context)=> Netflix   ()));
            },
          ),
          drawer: MenuLateral(),
        ),
      ),
    );
  }


  }

//        userDetails: details);
