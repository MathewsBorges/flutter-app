import 'package:clinicamedica/api/PersistenciaApi.dart';

import '../../view/telas/tela_inicial.dart';
import '../../view/telas/tela_menu.dart';

import '../models/paciente.dart';
import '../database/PersistenciaArquivoJson.dart';
import '../Helper/PacienteHelper.dart';

class LoginController {
  Future<Paciente> logar(String login, String password) async {
    PersistenciaApi helper = new PersistenciaApi();
    Paciente p1 = await helper.login(login, password);
    return p1;
  }
}
