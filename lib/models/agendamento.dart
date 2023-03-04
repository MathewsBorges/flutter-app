import 'package:clinicamedica/Helper/AgendamentoHelper.dart';
import 'package:clinicamedica/view/telas/tela_menu.dart';

import '../../models/agendamentoPropriedades.dart';

import '../controller/userController.dart';
import '../database/PersistenciaArquivoJson.dart';
import './agendamento.dart';
import 'paciente.dart';
import '../Helper/PacienteHelper.dart';

class Agendamento {
  static List<Agendamento> agenda = [];

  // ignore: prefer_final_fields
  int _idConsulta = 0;
  DateTime data = DateTime.now();
  String hora = "";
  String medico = "";
  Paciente paciente = Paciente();

  Agendamento(this.data, this.hora, this.medico, this.paciente) {}

  // ignore: unnecessary_this
  void set id(int id) {
    this._idConsulta = id;
  }

  int get idConsulta => this._idConsulta;

  String consulta() {
    // ignore: unnecessary_brace_in_string_interps
    return "Código da Consulta: ${idConsulta},Data: $data, Hora: $hora, |Paciente ID: ${paciente.id}  Nome: ${paciente.nome}|";
  }

  static void listarAgendamento() {
    for (var item in agenda) {
      // ignore: avoid_print
      print(
          "Código da Consulta: ${item.idConsulta},Data: ${item.data.day}/${item.data.month}/${item.data.year}, Hora: ${item.hora}, Médico: ${item.medico} |Paciente ID: ${item.paciente.id}  Nome: ${item.paciente.nome}|");
    }
  }

  Agendamento.fromMap(Map map) {
    _idConsulta = map[AgendamentoPropriedades.idConsulta];
    data =
        DateTime.fromMillisecondsSinceEpoch(map[AgendamentoPropriedades.data]);
    hora = map[AgendamentoPropriedades.hora];
    medico = map[AgendamentoPropriedades.medico];
  }

  Map<String, Object> toMap() {
    Map<String, Object> map = {
      AgendamentoPropriedades.data: data.millisecondsSinceEpoch,
      AgendamentoPropriedades.hora: hora,
      AgendamentoPropriedades.medico: medico,
      AgendamentoPropriedades.paciente: paciente.toMap(),
    };

    if (idConsulta > 0) {
      map[AgendamentoPropriedades.idConsulta] = _idConsulta;
    }
    return map;
  }

  static marcarConsulta(data, hora, medico, Paciente p1) {
    Agendamento agendar = new Agendamento(data, hora, medico, p1);
   
    AgendamentoHelper agenda = new AgendamentoHelper();
    p1.num++;
    PacienteHelper helper = new PacienteHelper();
    helper.atualizar(p1);
    agenda.salvar(agendar);
  }

  static removerConsulta(Agendamento consulta) async {
    Agendamento.agenda.remove(consulta);
 
    AgendamentoHelper helper = new AgendamentoHelper();
    PacienteHelper helperPaciente = new PacienteHelper();

    helper.remover(consulta.idConsulta);
    tela_menu.p1.num--;
    helperPaciente.atualizar(tela_menu.p1);
  }

  static numeroConsultas(int id) async {
    AgendamentoHelper helper = new AgendamentoHelper();
    int? num = await helper.quantidade(id);
    int? valor = num?.toInt();
    return valor;
  }
}
