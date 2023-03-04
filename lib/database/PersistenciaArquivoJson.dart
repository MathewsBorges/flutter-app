import 'package:path_provider/path_provider.dart';

import 'dart:convert';
import 'dart:io';

import '../models/paciente.dart';
import '../models/agendamento.dart';

class PersistenciaArquivoJson {
  //Arquivo dos Pacientes
  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();

    return File("${diretorio.path}/Pacientesdatabase.json");
  }

  //Arquivo dos Agendamentos
  Future<File> _getFileSchedule() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/AgendamentoBancoDAD.json");
  }

//---LEITURA
  Future<List<Paciente>> lerPacientes() async {
    List<Paciente> listaPacientesNoArquivo = [];

    String listaComoString = "";

    try {
      final arquivo = await _getFile();
      listaComoString = await arquivo.readAsString();
    } catch (e) {
      print("Erro na Leitura do arquivo Pacientes $e");
    }

    List mapPacientes = [];

    if (listaComoString.isNotEmpty) {
      mapPacientes = json.decode(listaComoString);
    }
    print(mapPacientes);

    for (Map pacienteMap in mapPacientes) {
      listaPacientesNoArquivo.add(Paciente.fromMap(pacienteMap));
    }

    return listaPacientesNoArquivo;
  }

  Future<List<Agendamento>> lerAgendamento() async {
    List<Agendamento> listaAgendamentoNoArquivo = [];

    String listaComoString = "";

    try {
      final arquivo = await _getFileSchedule();
      listaComoString = await arquivo.readAsString();
    } catch (e) {
      print("Erro na Leitura do arquivo Agendamento $e");
    }

    List mapAgendamentos = [];

    if (listaComoString.isNotEmpty) {
      mapAgendamentos = json.decode(listaComoString);
    }
    print(mapAgendamentos);
    for (Map agendamentoMap in mapAgendamentos) {
      listaAgendamentoNoArquivo.add(Agendamento.fromMap(agendamentoMap));
    }

    return listaAgendamentoNoArquivo;
  }

//--GRAVAR
  Future<File> gravarPaciente(Paciente paciente) async {
    List<Paciente> listaPacientes = await lerPacientes();
    listaPacientes.add(paciente);

    List mapPacientes = [];
    for (Paciente paciente in listaPacientes) {
      mapPacientes.add(paciente.toMap());
    }

    String listaComoString = json.encode(mapPacientes);
    final arquivo = await _getFile();
    print(arquivo);
  
    return arquivo.writeAsString(listaComoString);
  }

  Future<File> gravarAgendamento(Agendamento agenda) async {
    List<Agendamento> listaAgendamento = await lerAgendamento();
    listaAgendamento.add(agenda);

    List mapAgendamentos = [];
    for (Agendamento agenda in listaAgendamento) {
      mapAgendamentos.add(agenda.toMap());
    }

    String listaComoString = json.encode(mapAgendamentos);
    final arquivo = await _getFileSchedule();
    return arquivo.writeAsString(listaComoString);
  }
}
