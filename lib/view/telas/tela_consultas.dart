import '../../database/PersistenciaArquivoJson.dart';

import '../../controller/agendamentoController.dart';
import 'tela_agendamento.dart';
import 'package:flutter/material.dart';
import '../../models/agendamento.dart';
import 'tela_menu.dart';

import '../components/navbar.dart';

class Tela_Consultas extends StatefulWidget {
  const Tela_Consultas({Key? key}) : super(key: key);

  @override
  State<Tela_Consultas> createState() => _Tela_ConsultasState();
}

class _Tela_ConsultasState extends State<Tela_Consultas> {
  List<Agendamento> consultas = [];

  AgendamentoController agendamentoController = AgendamentoController();
  PersistenciaArquivoJson database = PersistenciaArquivoJson();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barraSuperior(),
      body: projectWidget(),
      floatingActionButton: botaoFlutuante(),
      drawer: navbar(),
    );
  }

  // corpo(context) {
  //   if (consultas.length == 0) {
  //     return Padding(
  //         padding: EdgeInsetsDirectional.fromSTEB(40, 10, 0, 10),
  //         child: Text(
  //           "Não há consultas registradas",
  //           style: TextStyle(fontSize: 18, color: Colors.grey),
  //         ));
  //   } else {
  //     // tela_menu.numConsultas = consultas.length;
  //     return ListView.builder(
  //       itemCount: consultas.length,
  //       itemBuilder: (context, index) {
  //         return itemDaListaRemovivel(consultas[index]);
  //       },
  //     );
  //   }
  // }

  Widget projectWidget() {
    return FutureBuilder(
      future: agenda(),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.data == "Vazio") {
          return Container(
            child: Text("Não há consultas"),
          );
        }

        return ListView.builder(
          itemCount: consultas.length,
          itemBuilder: (context, index) {
            return itemDaListaRemovivel(consultas[index]);
          },
        );
      },
    );
  }

  Future<String> agenda() async {
    AgendamentoController controller = new AgendamentoController();
    List<Agendamento> agendamentos = await controller.agendamentos();
    // print("teste......");
    //print(agendamentos);
    consultas = [];

    agendamentos.forEach((consulta) {
      consultas.add(consulta);
    });

    if (consultas.length == null) {
      return 'Vazio';
    } else {
      return "OK";
    }
  }

  itemDaListaRemovivel(Agendamento consultas) {
    return Dismissible(
      key: Key(consultas.idConsulta.toString()),
      child: itemDaLista(consultas),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        agendamentoController.removerConsulta(consultas);
      },
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Apagar Consulta"),
              content: const Text("Você quer apagar a consulta?"),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("SIM"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("NÃO"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  itemDaLista(Agendamento consultas) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.calendar_month_outlined),
        title: Text(
            "Data: ${consultas.data.day}/${consultas.data.month}/${consultas.data.year}  Hora: ${consultas.hora}"),
        subtitle: Text('Médico: ${consultas.medico}'),
      ),
    );
  }

  barraSuperior() {
    return AppBar(
      title: const Text("Minhas Consultas"),
      centerTitle: true,
      backgroundColor: Colors.green[600],
      leading: BackButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => tela_menu()));
        },
      ),
    );
  }

  botaoFlutuante() {
    return FloatingActionButton(
      child: Icon(Icons.playlist_add_outlined),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => tela_agendamento()));
      },
      backgroundColor: Colors.green,
    );
  }
}
