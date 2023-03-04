import 'package:clinicamedica/Helper/AgendamentoHelper.dart';
import 'package:clinicamedica/Helper/PacienteHelper.dart';
import 'package:clinicamedica/database/PersistenciaArquivoJson.dart';

import '../models/agendamento.dart';
import '../models/paciente.dart';
import '../Helper/AgendamentoHelper.dart';

class AgendamentoController {
  PersistenciaArquivoJson database = PersistenciaArquivoJson();
  AgendamentoHelper helper = new AgendamentoHelper();

  Future<String> checkarAgendamento(
      DateTime dataConsulta, String hora, String medico, int id) async {
    String flag = "ok";

    List<Agendamento> agenda = await helper.consultarConsultas();

    agenda.forEach((data) {
      if (data.paciente.id == id && data.data == dataConsulta) {
        flag = "Não foi possível agendar, você já tem uma consulta nesse dia";
      }
      if (data.data == dataConsulta &&
          data.hora == hora &&
          data.medico == medico) {
        flag = "Não foi possível agendar, Já a uma consulta nesse horário";
      }
    });

    // Agendamento.agenda.forEach((data) {
    //   if (data.paciente.id == id && data.data == dataConsulta) {
    //     flag = "Não foi possível agendar, você já tem uma consulta nesse dia";
    //   }
    //   if (data.data == dataConsulta &&
    //       data.hora == hora &&
    //       data.medico == medico) {
    //     flag = "Não foi possível agendar, Já a uma consulta nesse horário";
    //   }
    // });

    return flag;
  }

  void agendarConsulta(data, hora, Paciente p1, String medico) {
    Agendamento.marcarConsulta(data, hora, medico, p1);
    //Agendamento.marcarConsulta(data, hora, medico, p1);
  }

  void removerConsulta(Agendamento consulta) {
    Agendamento.removerConsulta(consulta);
  }

  Future<List<Agendamento>> agendamentos() async {
    AgendamentoHelper helper = new AgendamentoHelper();
    List<Agendamento> agendas = await helper.consultarTodos();
    return agendas;
  }
}
