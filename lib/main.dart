// ignore_for_file: unused_import


// ignore: unnecessary_import
import 'view/telas/tela_apresentacao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'view/telas/tela_menu.dart';
import 'view/telas/tela_inicial.dart';

import 'models/paciente.dart';
import 'models/agendamento.dart';
import 'database/PersistenciaArquivoJson.dart';
import 'api/PersistenciaApi.dart';
void main() {


  // ignore: prefer_const_constructors
  runApp(MaterialApp(
    title: "Clínica M",
    // ignore: prefer_const_constructors
    home: tela_apresentacao()
  ));









}
