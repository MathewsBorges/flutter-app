import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/paciente.dart';

class PersistenciaApi {
  String endereco = "192.168.23.1";

  String enderecoEmulador = "api-clinica.onrender.com";

  Future<int> inserirPaciente(Paciente paciente) async {
    print('Entrou na api');
    var url = Uri.https("$enderecoEmulador", '/paciente');
    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/json';

    http.Response resposta = await http.post(url,
        headers: headers,
        body: jsonEncode(paciente.toMap()),
        encoding: Encoding.getByName('utf-8'));

    if (resposta.statusCode >= 200 && resposta.statusCode < 300) {
      print('Inserção bem sucedida');
    } else {
      print('Deu ruim na inserção ${url.toString()} ${resposta.statusCode}');
    }
    return resposta.statusCode;
  }

  Future<List<Paciente>> carregarPaciente() async {
    print('entrou no get');
    var url = Uri.https("$enderecoEmulador", '/paciente');
    http.Response resposta = await http.get(url);

    if (resposta.statusCode >= 200 && resposta.statusCode < 300) {
      print('Carregamento bem sucedido');
    } else {
      print('Deu ruim no carregamento ');
    }

    var dados = json.decode(resposta.body);
    List<Paciente> lista = [];
    for (Map paciente in dados) {
      lista.add(Paciente.fromMap(paciente));
    }
    print(lista);
    return lista;
  }

  Future<Paciente> login(email, senha) async {
    var url = Uri.https('$enderecoEmulador', '/paciente/$email/$senha');
    var paciente;
    http.Response resposta = await http.get(url);
    if (resposta.statusCode >= 200 && resposta.statusCode < 300) {
      try {
        paciente = Paciente.fromMap(json.decode(resposta.body));
      } catch (e) {
        paciente = new Paciente();
      }
    } else {
      print('Erro ao buscar login');
    }

    return paciente;
  }
}
