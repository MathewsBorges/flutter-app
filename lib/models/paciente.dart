import 'package:clinicamedica/api/PersistenciaApi.dart';

import '../controller/userController.dart';
import 'pacientePropriedades.dart';
import '../view/telas/tela_menu.dart';
import '../Helper/PacienteHelper.dart';

class Paciente {
  static int numPaciente = 1;

  // ignore: prefer_final_fields
  int _id = numPaciente;
  String nome = "";
  int idade = 0;
  String endereco = "";
  String telefone = "";
  String email = "";
  String sexo = "";
  String password = "";
  int num = 0;

  void set id(int id) {
    this._id = id;
  }

  int get id => this._id;

  Paciente() {
    this.nome = "";
    this.idade = 0;
    this.endereco = "";
    this.telefone = "";
    this.email = "";
    this.password = "";
    this.sexo = "";
    this.num = 0;
  }

  Paciente.comParametro(
      String nome,
      int idade,
      String endereco,
      String telefone,
      String sexo,
      String email,
      String password,
      int num) {
    this.nome = nome;
    this.idade = idade > 0 ? idade : 0;
    this.endereco = endereco;
    this.telefone = telefone;
    this.email = email;
    this.sexo = sexo;
    this.password = password;
    this.num = numConsultas;
    numPaciente++;
  }

  String toString() {
    return "ID: $id, Nome: $nome, Idade: $idade, Endereço: $endereco, Telefone: $telefone, Sexo: $sexo, Email: $email, Senha: $password, Num: $num";
  }

  static List<Paciente> pacientes = [
    Paciente.comParametro(
        "Admin", 20, "Teste", "996090850", "Masculino", "matheus@", "1234", 0),
  ];

  Paciente.fromMap(Map map) {
    _id = map[PacientePropriedades.id];
    nome = map[PacientePropriedades.nome];
    idade = map[PacientePropriedades.idade];
    endereco = map[PacientePropriedades.endereco];
    telefone = map[PacientePropriedades.telefone];
    sexo = map[PacientePropriedades.sexo];
    email = map[PacientePropriedades.email];
    password = map[PacientePropriedades.password];
    num = map[PacientePropriedades.num];
  }

  Map<String, Object> toMap() {
    Map<String, Object> map = {
      PacientePropriedades.nome: nome,
      PacientePropriedades.idade: idade,
      PacientePropriedades.endereco: endereco,
      PacientePropriedades.telefone: telefone,
      PacientePropriedades.sexo: sexo,
      PacientePropriedades.email: email,
      PacientePropriedades.password: password,
      PacientePropriedades.num: num,
    };

    // if (id > 0) {
    //   map[PacientePropriedades.id] = _id;
    // }

    return map;
  }

  addUsuario(nome, idade, endereco, celular, sexo, email, password, num) {
    int age = int.parse(idade);
    Paciente novoPaciente = Paciente.comParametro(
        nome, age, endereco, celular, sexo, email, password, num);
    Paciente.pacientes.add(novoPaciente);
    // database.gravarPaciente(novoPaciente);
    // PacienteHelper paciente = new PacienteHelper();
    PersistenciaApi paciente = new PersistenciaApi();
    paciente.inserirPaciente(novoPaciente);
  }

  editUsuario(id, nome, idade, endereco, telefone, email, password) async {
    // List<Paciente> listaPacientes = await database.lerPacientes();
    PacienteHelper paciente = new PacienteHelper();
    Paciente pacientes = await paciente.consultar(id);
    pacientes.nome = nome;
    pacientes.idade = int.parse(idade);
    pacientes.endereco = endereco;
    pacientes.telefone = telefone;
    pacientes.email = email;
    pacientes.password = password;
    paciente.atualizar(pacientes);
    tela_menu.p1 = pacientes;
  }
}
