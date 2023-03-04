import '../../controller/userController.dart';
import 'package:flutter/material.dart';
import 'tela_menu.dart';

import '../../models/paciente.dart';
import '../Components/navbar.dart';
import 'tela_menu.dart';

class tela_editar extends StatefulWidget {
  const tela_editar({Key? key}) : super(key: key);

  @override
  _tela_editarState createState() => _tela_editarState();
}

class _tela_editarState extends State<tela_editar> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();

  late bool loginVisibility;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  UserController userController = UserController();

  @override
  void initState() {
    loginVisibility = false;
    _nomeController.text = tela_menu.p1.nome;
    _idadeController.text = tela_menu.p1.idade.toString();
    _enderecoController.text = tela_menu.p1.endereco;
    _telefoneController.text = tela_menu.p1.telefone;
    _emailController.text = tela_menu.p1.email;
    _loginController.text = tela_menu.p1.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appbar(),
      backgroundColor: Colors.white,
      body: corpo(context),
      drawer: navbar(),
    );
  }

  corpo(context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          input(_nomeController, "Informe seu nome", Icon(Icons.person)),
          input(_idadeController, "Informe sua idade",
              Icon(Icons.date_range_outlined),
              keyboardType: TextInputType.number),
          input(_enderecoController, "Informe seu Endereço", Icon(Icons.house),
              keyboardType: TextInputType.streetAddress),
          input(_telefoneController, "Informe seu Telefone", Icon(Icons.phone),
              keyboardType: TextInputType.phone),
          inputSenha(),
          SizedBox(height: 50),
          botaoTela("Salvar Mudanças", Icon(Icons.save), context),
          SizedBox(height: 50),
        ]),
      ),
    );
  }

  input(TextEditingController control, String label, icone,
      {keyboardType = TextInputType.name}) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 16),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: control,
        obscureText: false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x00000000),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x00000000),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
          prefixIcon: icone,
        ),
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  botaoTela(String texto, Icon icon, BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () async {
          String nome = _nomeController.text;
          String idade = _idadeController.text;
          String celular = _telefoneController.text;
          String endereco = _enderecoController.text;

          String password = _loginController.text;

          String testes =  userController.teste(tela_menu.p1, nome, idade,
              celular, endereco, password);

          if (testes == "Cadastrado") {
            userController.editarUser(tela_menu.p1.id, nome, idade, endereco,
                celular, tela_menu.p1.email, password);
            ScaffoldMessenger.of(context)
                .showSnackBar(mensagem("Cadastro Editado com Sucesso"));
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => tela_menu()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(mensagem(testes));
          }
        },
        icon: icon,
        label: Text(texto),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xFF52B788)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(50),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
        ));
  }

  appbar() {
    return AppBar(
      title: Text("Editar"),
      backgroundColor: Colors.green[600],
      leading: BackButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => tela_menu()));
        },
      ),
    );
  }

  inputSenha() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 16),
      child: TextFormField(
        controller: _loginController,
        obscureText: !loginVisibility,
        decoration: InputDecoration(
          iconColor: Colors.grey,
          labelText: 'Senha de Login',
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
          prefixIcon: Icon(
            Icons.lock_outline,
          ),
          suffixIcon: InkWell(
            onTap: () => setState(
              () => loginVisibility = !loginVisibility,
            ),
            focusNode: FocusNode(skipTraversal: true),
            child: Icon(
              loginVisibility
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Color(0xFF757575),
              size: 22,
            ),
          ),
        ),
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  mensagem(texto) {
    return SnackBar(
      duration: Duration(seconds: 5),
      content: Text(texto),
    );
  }
}
