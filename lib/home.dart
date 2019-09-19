import 'package:app_vai/menuLateral.dart';
import 'package:flutter/material.dart';
import 'espera.dart';
import 'pausados.dart';
import 'andamento.dart';
import 'finalizado.dart';

class TabBarDemo extends StatelessWidget {
  String nomeTab= "Chamados";

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
                Tab(icon: Icon(Icons.hourglass_full), text: ("em espera"),),
                Tab(icon: Icon(Icons.pause), text: ("pausados"),),
                Tab(icon: Icon(Icons.build), text: ("atendendo"),),
                Tab(icon: Icon(Icons.check), text: ("Finalizados"),),
              ],
            ),
            title: Text(nomeTab),
          ),


          body: TabBarView(
            children: [
              Espera(),
              Pausa(),
              Andamento(),
              Finalizado(),
            ],
          ),
          drawer: MenuLateral(

          ),
        ),

      ),
    );
  }

}