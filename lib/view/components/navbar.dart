import '/models/paciente.dart';
import '/view/telas/tela_menu.dart';

import 'package:flutter/material.dart';

import '../telas/tela_consultas.dart';
import '../telas/tela_contato.dart';
import '../telas/tela_inicial.dart';
import '../telas/tela_editar.dart';
import '../telas/tela_menu.dart';

class navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Column(
            children: [
              Stack(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/imagens/background.jpg")),
                    ),
                    accountName: Text(tela_menu.p1.nome),
                    accountEmail: Text(tela_menu.p1.email),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.green,
                      backgroundImage: AssetImage("assets/imagens/user.jpg"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(220, 0, 0, 20),
                    child: ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.cancel),
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  primary: Colors.red,
                                  side: BorderSide(
                                      width: 10, color: Colors.white))),
                        ]),
                  ),
                ],
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.calendar_month_outlined),
            title: Text("Minhas Consultas"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Tela_Consultas()));
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Editar Cadastro"),
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => tela_editar()));
            },
          ),
          ListTile(
            leading: Icon(Icons.contacts),
            title: Text("Contatos"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => tela_contato()));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app_outlined),
            title: Text("Sair"),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TelaInicial()));
            },
          ),
        ],
      ),
    );
  }
}
