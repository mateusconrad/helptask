import 'package:app_vai/menuLateral.dart';
import 'package:flutter/material.dart';
import 'tabs/espera.dart';
import 'tabs/pausados.dart';
import 'tabs/andamento.dart';
import 'tabs/finalizado.dart';
import 'package:app_vai/abrir_chamado.dart';

class TabBarDemo extends StatelessWidget {
  String nomeTab = "Chamados";

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
            onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AbrirChamado()));
            },
          ),
          drawer: MenuLateral(),

        ),
      ),
    );
  }
}
