// ignore_for_file: prefer_const_constructors, duplicate_ignore, avoid_unnecessary_containers

import '../../controller/loginController.dart';

import '../../controller/loginController.dart';
import '../../controller/loginController.dart';
import '../../database/PersistenciaArquivoJson.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/paciente.dart';
import 'tela_cadastro.dart';
import 'tela_menu.dart';
import '../../api/PersistenciaApi.dart';
  PersistenciaApi p = new PersistenciaApi();
  
class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final LoginController loginController = new LoginController();

  late bool loginVisibility;

  bool flag = false;

  @override
  void initState() {
    loginVisibility = false;
    p.carregarPaciente();

  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body: corpo(context),
    );
  }

  Widget corpo(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              imagemFundo(),
              Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_hospital_outlined,
                          color: Colors.white,
                          size: 50,
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
                        textoPrincipal("iHealth"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: formulario(),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  botaoLogin(context),
                  botaoCadastrar(context),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  imagemFundo() {
    return Image.asset(
      "assets/imagens/background.jpg",
      fit: BoxFit.cover,
      height: 540,
    );
  }

  textoPrincipal(String text) {
    return Center(
      child: Text(
        text,
        style:
            TextStyle(fontSize: 100, color: Colors.white, fontFamily: 'Love'),
      ),
    );
  }

  botaoLogin(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () async {
          await logar();

          if (flag) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => tela_menu()));
            _loginController.clear();
            _senhaController.clear();
          } else {
            showAlertDialog1(context);
          }
        },
        icon: Icon(Icons.login),
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF52B788),
        ),
        label: Text("Login"));
  }

  botaoCadastrar(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => tela_cadastro()));
      },
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF52B788),
      ),
      child: Text(
        "Cadastrar-se",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  formulario() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          campoFormulario(_loginController, "Login", "Informe seu Login",
              Icons.person_rounded),
          campoSenha(),
        ],
      ),
    );
  }

  campoFormulario(TextEditingController controller, String label, String dica,
      IconData icone) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        icon: Icon(icone, color: Colors.white),
        hintText: dica,
        labelText: label,
        iconColor: Colors.white,
        labelStyle: TextStyle(color: Colors.white, fontSize: 20),
        hintStyle: TextStyle(color: Colors.white),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.green,
        )),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Preenchimento Obrigatório';
        }
        return null;
      },
    );
  }

  showAlertDialog1(BuildContext context) {
    Widget okButton = ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF52B788)),
      ),
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alerta = AlertDialog(
      title: Text("Falha"),
      content: Text("Usuário não encontrado"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  campoSenha() {
    return TextFormField(
      controller: _senhaController,
      obscureText: !loginVisibility,
      decoration: InputDecoration(
        icon: Icon(Icons.lock, color: Colors.white),
        hintText: "Informe sua Senha",
        labelText: "Senha",
        iconColor: Colors.white,
        labelStyle: TextStyle(color: Colors.white, fontSize: 20),
        hintStyle: TextStyle(color: Colors.white),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.green,
        )),
        suffixIcon: InkWell(
          onTap: () => setState(
            () => loginVisibility = !loginVisibility,
          ),
          focusNode: FocusNode(skipTraversal: true),
          child: Icon(
            loginVisibility
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  logar() async {
    String login = _loginController.text;
    String password = _senhaController.text;
    Paciente p1 = await loginController.logar(login, password);
    if (p1.email !="") {
      tela_menu.p1 = p1;
      flag = true;
    } else {
      flag = false;
    }
  }
}
