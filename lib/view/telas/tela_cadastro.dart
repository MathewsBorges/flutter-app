import '../../controller/userController.dart';
import '../telas/tela_menu.dart';

import 'tela_inicial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/paciente.dart';

class tela_cadastro extends StatefulWidget {
  const tela_cadastro({Key? key}) : super(key: key);

  @override
  State<tela_cadastro> createState() => _tela_cadastroState();
}

class _tela_cadastroState extends State<tela_cadastro> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _contatoController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  UserController userController = UserController();
  String problema = "";

  bool validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: corpo(context),
      appBar: barraSuperior(),
    );
  }

  corpo(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          formulario(),
        ],
      ),
    );
  }

  formulario() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Stack(
            children: [
              imagemFundo(),
              Padding(
                  padding: const EdgeInsets.fromLTRB(75, 10, 0, 0),
                  child: textoPrincipal("Cadastre-se")),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 60, 15, 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    campoFormulario(
                        _nomeController, "Nome", "Nome Completo", Icons.person,
                        keyboardType: TextInputType.name),
                    campoFormulario(_dataController, "Idade",
                        "Informe a sua idade", Icons.lock_clock,
                        keyboardType: TextInputType.number),
                    campoFormulario(_contatoController, "Celular",
                        "(xxx) xxxx-xxxxx", Icons.phone,
                        keyboardType: TextInputType.phone),
                    campoFormulario(_enderecoController, "Endereço",
                        "Informe seu Endereço", Icons.house,
                        keyboardType: TextInputType.streetAddress),
                    SizedBox(
                      height: 30,
                    ),
                    texto("Sexo"),
                    radioButton("Masculino", Icons.man_rounded),
                    radioButton("Feminino", Icons.woman_rounded),
                    SizedBox(
                      height: 30,
                    ),
                    campoFormulario(_emailController, "Email de Login",
                        "Informe o Email de Login", Icons.email,
                        keyboardType: TextInputType.emailAddress),
                    campoFormulario(_senhaController, "Senha de Login",
                        "Informe a Senha de Login", Icons.key,
                        keyboardType: TextInputType.visiblePassword),
                    SizedBox(
                      height: 30,
                    ),
                    botaoCadastrar(context)
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  campoFormulario(TextEditingController controller, String label, String dica,
      IconData icone,
      {keyboardType = TextInputType.name}) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        icon: Icon(icone, color: Colors.white),
        hintText: dica,
        labelText: label,
        iconColor: Colors.white,
        labelStyle: const TextStyle(color: Colors.white, fontSize: 16),
        hintStyle: const TextStyle(color: Colors.white),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        enabledBorder: const UnderlineInputBorder(
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

  String _radioSelecionado = "Masculino";

  radioButton(String texto, IconData icone) {
    return RadioListTile<String>(
        value: texto,
        groupValue: _radioSelecionado,
        title: Text(
          texto,
          style: TextStyle(color: Colors.white),
        ),
        secondary: Icon(icone, color: Colors.white),
        activeColor: Colors.green,
        onChanged: (value) {
          setState(() {
            _radioSelecionado = value!;
          });
        });
  }

  texto(String txt) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: 17,
        color: Colors.white,
      ),
    );
  }

  barraSuperior() {
    return AppBar(
      title: Text("Cadastro"),
      backgroundColor: Colors.green[400],
      actions: [],
    );
  }

  botaoCadastrar(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          controlador();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
        ),
        icon: Icon(Icons.person_add),
        label: Text("Cadastrar"));
  }

  controlador() async {
    String nome = _nomeController.text;
    print(nome);
    String idade = _dataController.text;
    String celular = _contatoController.text;
    String endereco = _enderecoController.text;
    String sexo = _radioSelecionado.characters.string;
    String email = _emailController.text;
    String password = _senhaController.text;

    String teste = await userController.testes(
        tela_menu.p1, nome, idade, celular, endereco, email, password);

    if (teste == "Cadastrado") {
      userController.addUser(
          nome, idade, endereco, celular, sexo, email, password, 0);
      showAlertDialog1(context, "Cadastrado", "Seu Usuário Foi cadastrado");
      limpar();
    } else {
      showAlertDialog1(context, "Falha!", "${teste}");
    }
  }

  showAlertDialog1(BuildContext context, String texto1, String texto2) {
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TelaInicial()));
      },
    );

    AlertDialog alerta = AlertDialog(
      title: Text(texto1),
      content: Text(texto2),
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

  limpar() {
    _nomeController.clear();
    _dataController.clear();
    _contatoController.clear();
    _enderecoController.clear();
    _emailController.clear();
    _senhaController.clear();
  }

  textoPrincipal(String text, {double tamanho = 70}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: tamanho,
        color: Colors.white,
        fontFamily: "Love",
      ),
    );
  }

  imagemFundo() {
    return Image.asset(
      "assets/imagens/background.jpg",
      fit: BoxFit.cover,
      height: 750,
    );
  }
}
