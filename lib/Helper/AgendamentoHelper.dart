import 'package:clinicamedica/models/agendamento.dart';
import 'package:clinicamedica/view/telas/tela_menu.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/paciente.dart';
import '../models/agendamentoPropriedades.dart';

class AgendamentoHelper {
  static final AgendamentoHelper _instance = AgendamentoHelper._interno();

  factory AgendamentoHelper() => _instance;
  AgendamentoHelper._interno();

  Database? _banco;
  String tabelaAgendamento = "agenda";

  Future<Database> get banco async {
    if (_banco != null) {
      return _banco!;
    } else {
      _banco = await iniciarBanco();
      return _banco!;
    }
  }

  Future<Database> iniciarBanco() async {
    final caminhoDoBanco = await getDatabasesPath();
    final caminho = join(caminhoDoBanco, "agenda.db");
    const versao = 2;

    String sqlCriarBanco = "CREATE TABLE $tabelaAgendamento("
        "${AgendamentoPropriedades.idConsulta} INTEGER PRIMARY KEY AUTOINCREMENT, "
        "${AgendamentoPropriedades.data} INTEGER, "
        "${AgendamentoPropriedades.hora} TEXT, "
        "${AgendamentoPropriedades.paciente} INTEGER, "
        "${AgendamentoPropriedades.medico} TEXT)";

    String destruirBanco = "DROP TABLE $tabelaAgendamento";

    return openDatabase(
      caminho,
      version: versao,
      onCreate: (banco, versaoNova) async {
        print("Criando Banco com versão $versaoNova");
        await banco.execute(sqlCriarBanco);
      },
      onUpgrade: (banco, versaoAntiga, versaoNova) async {
        print(
            "Atualizando banco de versão $versaoAntiga para versão $versaoNova");
        await banco.execute(destruirBanco);
        await banco.execute(sqlCriarBanco);
      },
    );
  }

  Future<Agendamento> salvar(Agendamento agenda) async {
    Database bancoAgendamento = await banco;
    var map = agenda.toMap();
    map[AgendamentoPropriedades.paciente] = agenda.paciente.id;
    print(map);
    agenda.id = await bancoAgendamento.insert(tabelaAgendamento, map);
    return agenda;
  }

  Future<Agendamento> consultar(int id) async {
    Database bancoAgendamento = await banco;
    List<Map> retorno = await bancoAgendamento.query(tabelaAgendamento,
        columns: [
          AgendamentoPropriedades.idConsulta,
          AgendamentoPropriedades.data,
          AgendamentoPropriedades.hora,
          AgendamentoPropriedades.medico,
          AgendamentoPropriedades.paciente
        ],
        where: "${AgendamentoPropriedades.idConsulta} = ?",
        whereArgs: [id]);
    if (retorno.isNotEmpty) {
      return Agendamento.fromMap(retorno.first);
    } else {
      return null!;
    }
  }

  Future<List<Agendamento>> consultarTodos() async {
    Database bancoAgendamento = await banco;
    var id = tela_menu.p1.id;
    List<Map> retorno = await bancoAgendamento
        .rawQuery("SELECT * FROM $tabelaAgendamento where paciente =  $id");
    List<Agendamento> agendamentos = [];
    for (Map agenda in retorno) {
      agendamentos.add(Agendamento.fromMap(agenda));
    }
    return agendamentos;
  }

  Future<List<Agendamento>> consultarConsultas() async {
    Database bancoAgendamento = await banco;
    var id = tela_menu.p1.id;
    List<Map> retorno = await bancoAgendamento
        .rawQuery("SELECT * FROM $tabelaAgendamento");
    List<Agendamento> agendamentos = [];
    for (Map agenda in retorno) {
      agendamentos.add(Agendamento.fromMap(agenda));
    }
    return agendamentos;
  }

  Future<int> atualizar(Agendamento agenda) async {
    Database bancoAgendamento = await banco;
    return await bancoAgendamento.update(tabelaAgendamento, agenda.toMap(),
        where: "${AgendamentoPropriedades.idConsulta}=?",
        whereArgs: [agenda.idConsulta]);
  }

  Future<int> remover(int id) async {
    print(id);
    Database bancoAgendamento = await banco;
    return await bancoAgendamento.delete(tabelaAgendamento,
        where: "${AgendamentoPropriedades.idConsulta}=?", whereArgs: [id]);
  }

  Future<int?> quantidade(int id) async {
    Database bancoAgendamento = await banco;
    return Sqflite.firstIntValue(await bancoAgendamento.rawQuery(
        "SELECT COUNT (*) from $tabelaAgendamento where paciente = $id"));
  }
}
