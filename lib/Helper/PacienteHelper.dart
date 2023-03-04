import 'package:clinicamedica/models/pacientePropriedades.dart';
import 'package:clinicamedica/view/telas/tela_menu.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/paciente.dart';

class PacienteHelper {
  static final PacienteHelper _instance = PacienteHelper._interno();

  factory PacienteHelper() => _instance;
  PacienteHelper._interno();

  Database? _banco;
  String tabelaPaciente = "paciente";

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
    final caminho = join(caminhoDoBanco, "paciente.db");
    const versao = 2;

    String sqlCriarBanco = "CREATE TABLE $tabelaPaciente("
        "${PacientePropriedades.id} INTEGER PRIMARY KEY AUTOINCREMENT, "
        "${PacientePropriedades.nome} TEXT, "
        "${PacientePropriedades.idade} INTEGER, "
        "${PacientePropriedades.endereco} TEXT, "
        "${PacientePropriedades.telefone} TEXT, "
        "${PacientePropriedades.email} TEXT, "
        "${PacientePropriedades.password} TEXT, "
        "${PacientePropriedades.num} INTEGER)";

    String destruirBanco = "DROP TABLE $tabelaPaciente";

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

  Future<Paciente> salvar(Paciente paciente) async {
    Database bancoPaciente = await banco;
    paciente.id = await bancoPaciente.insert(tabelaPaciente, paciente.toMap());
    return paciente;
  }

  Future<Paciente> consultar(int id) async {
    Database bancoPaciente = await banco;
    List<Map> retorno = await bancoPaciente.query(tabelaPaciente,
        columns: [
          PacientePropriedades.id,
          PacientePropriedades.nome,
          PacientePropriedades.idade,
          PacientePropriedades.endereco,
          PacientePropriedades.email,
          PacientePropriedades.telefone,
          PacientePropriedades.password,
          PacientePropriedades.num
        ],
        where: "${PacientePropriedades.id} = ?",
        whereArgs: [id]);
    if (retorno.isNotEmpty) {
      return Paciente.fromMap(retorno.first);
    } else {
      return null!;
    }
  }

  Future<List<Paciente>> consultarTodos() async {
    Database bancoPaciente = await banco;
    List<Map> retorno =
        await bancoPaciente.rawQuery("SELECT * FROM $tabelaPaciente");
    List<Paciente> pacientes = [];
    for (Map paciente in retorno) {
      pacientes.add(Paciente.fromMap(paciente));
    }
    return pacientes;
  }

  Future<bool> consultarEmail(email) async {
    Database bancoPaciente = await banco;
    List<Map> retorno = await bancoPaciente.query(tabelaPaciente,
        where: "${PacientePropriedades.email} = ?", whereArgs: [email]);

    if (retorno.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<int> atualizar(Paciente paciente) async {
    Database bancoPaciente = await banco;
    return await bancoPaciente.update(tabelaPaciente, paciente.toMap(),
        where: "${PacientePropriedades.id}=?", whereArgs: [paciente.id]);
  }

  Future<int> remover(int id) async {
    Database bancoPaciente = await banco;
    return await bancoPaciente.delete(tabelaPaciente,
        where: "${PacientePropriedades.id}=?", whereArgs: [id]);
  }

  Future<int?> quantidade() async {
    Database bancoPaciente = await banco;
    return Sqflite.firstIntValue(
        await bancoPaciente.rawQuery("SELECT COUNT (*) from $tabelaPaciente"));
  }

  Future<Paciente> login(String email, String senha) async {
    Database bancoPaciente = await banco;
    List<Map> retorno = await bancoPaciente.query(tabelaPaciente,
        where: "${PacientePropriedades.email} = ?"
            " AND "
            "${PacientePropriedades.password} = ?",
        whereArgs: [email, senha]);
    if (retorno.isNotEmpty) {
      return Paciente.fromMap(retorno.first);
    } else {
      return Paciente();
    }
  }
}
