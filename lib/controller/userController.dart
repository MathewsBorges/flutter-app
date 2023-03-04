import '../../view/telas/tela_menu.dart';

import '../database/PersistenciaArquivoJson.dart';

import '../models/paciente.dart';
import '../Helper/PacienteHelper.dart';

PersistenciaArquivoJson database = new PersistenciaArquivoJson();
PacienteHelper helper = new PacienteHelper();

class UserController {
  addUser(nome, idade, endereco, celular, sexo, email, password, num) {
    Paciente paciente = new Paciente();
    paciente.addUsuario(
        nome, idade, endereco, celular, sexo, email, password, num);
  }

  editarUser(id, nome, idade, endereco, telefone, email, password) async {
    Paciente paciente = new Paciente();
    paciente.editUsuario(id, nome, idade, endereco, telefone, email, password);

    // Paciente.pacientes.forEach((paciente) {
    //   if (paciente.id == id) {
    //     paciente.nome = nome;
    //     paciente.idade = idade;
    //     paciente.endereco = endereco;
    //     paciente.telefone = telefone;
    //     paciente.email = email;
    //     paciente.password = password;
    //   }
    // });
  }

  Future<String> testes(
      id, nome, idade, celular, endereco, email, password) async {
    String status = "Cadastrado";
    bool emailStatus = await helper.consultarEmail(email);

    if (nome.isEmpty) {
      status = "Nome não pode ser vazio";
    }

    if (celular.length > 12 || celular.length < 6) {
      status = "Número de telefone inválido";
    }

    if (endereco.isEmpty) {
      status = "Endereço não pode ser vazio";
    }

    if (emailStatus) {
      status = "Email Já em uso";
    }

    if (!email.contains("@") || email.isEmpty) {
      status = "Email Inválido";
    }
    if (password.isEmpty) {
      status = "Senha não pode ser vazia";
    }
    return status;
  }

  String teste(id, nome, idade, celular, endereco, password)  {
    String status = "Cadastrado";

    if (nome.isEmpty) {
      status = "Nome não pode ser vazio";
    }

    if (celular.length > 12 || celular.length < 6) {
      status = "Número de telefone inválido";
    }

    if (endereco.isEmpty) {
      status = "Endereço não pode ser vazio";
    }


    if (password.isEmpty) {
      status = "Senha não pode ser vazia";
    }
    return status;
  }
}
