import '../../controller/agendamentoController.dart';
import '../../controller/agendamentoController.dart';
import 'tela_consultas.dart';
import '../../models/agendamento.dart';
import '../../models/paciente.dart';
import 'tela_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../components/navbar.dart';

class tela_agendamento extends StatefulWidget {
  const tela_agendamento({Key? key}) : super(key: key);

  @override
  State<tela_agendamento> createState() => _tela_agendamentoState();
}

class _tela_agendamentoState extends State<tela_agendamento> {
  @override
  final _formularioKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _medicoController = TextEditingController();

  AgendamentoController controllerAgendamento = AgendamentoController();

  List<String> items = [
    "08:30",
    "09:30",
    "10:30",
    "11:30",
    "13:30",
    "14:30",
    "15:30",
  ];

  List<String> medicos = ["Dr.João", "Dr.Renato", "Dra.Roberta", "Dra.Angela"];
  String medico = "Dr.João";
  String horario = "08:30";


  DateTime date = DateTime.now();

  Widget build(BuildContext context) {
    return Scaffold(
      body: corpo(context),
      appBar: barraSuperior(),
      drawer: navbar(),
    );
  }

  Widget corpo(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              imagemFundo(),
              Column(
                children: [
                  formulario(context, date),
                  Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
                  botaoAgendarConsulta(date),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  formulario(BuildContext context, DateTime data) {
    return Form(
      key: _formularioKey,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              "Agende Sua Consulta Aqui",
              style: TextStyle(
                fontSize: 45,
                color: Colors.white,
                fontFamily: 'Love',
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.green,
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text('Data da Consulta:  ${data.day}/${data.month}/${data.year}',
                style: TextStyle(fontSize: 18, color: Colors.white)),
            SizedBox(
              height: 10,
            ),
            botaoData(context, date),
            SizedBox(height: 30),
            Row(
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text("Horário",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: dropBoxHora(items)),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.medical_services_rounded,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text("Médico",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: dropBoxMed(medicos)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  campoFormulario(TextEditingController controller, String label, String dica,
      IconData icone,
      {keyboardType = TextInputType.name}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration:
          InputDecoration(icon: Icon(icone), hintText: dica, labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Preenchimento Obrigatório';
        }
        return null;
      },
    );
  }

  barraSuperior() {
    return AppBar(
      title: Text("Agendamento"),
      backgroundColor: Colors.green[600],
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.assignment),
          tooltip: 'Minhas Consultas',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Tela_Consultas()));
            // handle the press
          },
        ),
      ],
      leading: BackButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => tela_menu()));
        },
      ),
    );
  }

  botaoAgendarConsulta(DateTime data) {
    return ElevatedButton.icon(
        onPressed: () async {
          DateTime dataConsulta = data;
          Agendamento.agenda.forEach((element) {
            print(element);
          });
          String status = await controllerAgendamento.checkarAgendamento(
              dataConsulta, horario, medico, tela_menu.p1.id);

          if (status == "ok") {
            controllerAgendamento.agendarConsulta(data, horario, tela_menu.p1, medico);

            ScaffoldMessenger.of(context)
                .showSnackBar(mensagem("Consulta Cadastrada"));

            _nameController.clear();
            _medicoController.clear();

            telaAtualizar = telaAtualizar;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(mensagem(status));
          }
        },
        style: ElevatedButton.styleFrom(primary: Colors.green[500]),
        icon: Icon(Icons.edit),
        label: Text("Agendar"));
  }

  botaoData(BuildContext context, data) {
    return ElevatedButton.icon(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: data,
            firstDate: DateTime.now(),
            lastDate: DateTime(2024),
          );
          if (newDate == null) return;
          if (newDate.isBefore(data)) {}
          setState(() => date = newDate);
        },
        style: ElevatedButton.styleFrom(primary: Colors.green[500]),
        icon: Icon(Icons.calendar_month),
        label: Text("Selecionar Data"));
  }

  dropBoxHora(List<String> items) {
    return DropdownButton(
        value: horario,
        icon: const Icon(Icons.keyboard_arrow_down),
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.white,
        dropdownColor: Colors.green,
        style: TextStyle(color: Colors.white, fontSize: 18),
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          print(newValue);
          setState(() => horario = newValue!);
        });
  }

  dropBoxMed(List<String> items) {
    return DropdownButton(
        value: medico,
        icon: const Icon(Icons.keyboard_arrow_down),
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.white,
        dropdownColor: Colors.green,
        style: TextStyle(color: Colors.white, fontSize: 18),
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          print(newValue);
          setState(() => medico = newValue!);
        });
  }

  imagemFundo() {
    return Image.asset(
      "assets/imagens/background.jpg",
      fit: BoxFit.cover,
      height: 453,
    );
  }

  mensagem(texto) {
    return SnackBar(
      duration: Duration(seconds: 5),
      content: Text(texto),
    );
  }
}
