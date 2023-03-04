import 'package:clinicamedica/view/components/buttonBar.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import '../../models/agendamento.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'tela_editar.dart';
import '../../models/paciente.dart';
import 'tela_consultas.dart';
import '../components/navbar.dart';
import 'tela_agendamento.dart';
import 'tela_contato.dart';
import 'tela_inicial.dart';

import 'package:simple_gradient_text/simple_gradient_text.dart';

_tela_menuState telaAtualizar = _tela_menuState();
int numConsultas = 0;

class tela_menu extends StatefulWidget {
  const tela_menu({Key? key}) : super(key: key);

  @override
  State<tela_menu> createState() => _tela_menuState();
  static Paciente p1 = new Paciente();
}

class _tela_menuState extends State<tela_menu> {
  @override
  void initState() {
    super.initState();
    telaAtualizar = _tela_menuState();
  }

  @override
  PageController? pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appbar(),
      backgroundColor: Colors.white,
      drawer: navbar(),
      body: corpo(context),
    );
  }

  numConsultas(Paciente p1) {
    int consultas = tela_menu.p1.num;
   
    return consultas > 0
        ? "Você tem ${consultas} consultas"
        : "Você não tem consultas";
  }

  //Functions --------------------------------------------------------------------------------------------------------------------------
  //Appbar
  appbar() {
    return AppBar(
      backgroundColor: Color(0xFF40916C),
      automaticallyImplyLeading: true,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
            child: Text(
              'iHealth',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
      centerTitle: false,
      elevation: 2,
    );
  }

//Botao Agendar Consultar, Minhas Consultas, Contatos
  botaoTela(String texto, Icon icon, BuildContext context, tela) {
    return ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => tela));
        },
        icon: icon,
        label: Text(texto),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xFF52B788)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(50),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
        ));
  }

  Textos(texto, fonte, cor, double tamanho, peso) {
    return Text(
      texto,
      style: TextStyle(
        fontFamily: fonte,
        color: cor,
        fontSize: tamanho,
        fontWeight: peso,
      ),
    );
  }

  corpo(context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Color(0xFFF1F4F8)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 32, 16, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Textos('Olá,', 'Outfit', Color(0xFF101213), 32,
                              FontWeight.normal),
                          InkWell(
                            onTap: () async {
                              scaffoldKey.currentState!.openDrawer();
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Image.asset('assets/imagens/user.jpg'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
                              child: Textos('${tela_menu.p1.nome}', 'Outfit',
                                  Color(0xFF95D5B2), 32, FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 130,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 20),
                                    child: PageView(
                                      controller: pageViewController ??=
                                          PageController(initialPage: 0),
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8, 8, 8, 8),
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 5,
                                                    color: Color(0x32000000),
                                                    offset: Offset(0, 2))
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(16, 16, 16, 16),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .local_hospital_outlined,
                                                      color: Color(0xFF1B4332),
                                                      size: 48),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16, 0, 0, 0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Textos(
                                                            'Consultas',
                                                            'Outfit',
                                                            Color(0xFF101213),
                                                            22,
                                                            FontWeight.w500),
                                                        Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        4,
                                                                        0,
                                                                        0),
                                                            child: Textos(
                                                                '${numConsultas(tela_menu.p1)}',
                                                                'Outfit',
                                                                Color(
                                                                    0xFF57636C),
                                                                14,
                                                                FontWeight
                                                                    .w500)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8, 8, 8, 8),
                                          child: Container(
                                            width: 300,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 5,
                                                  color: Color(0x32000000),
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(16, 16, 16, 16),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    Icons.medication_rounded,
                                                    color: Color(0xFF39D2C0),
                                                    size: 48,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16, 0, 0, 0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Receitas',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Outfit',
                                                            color: Color(
                                                                0xFF101213),
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      4, 0, 0),
                                                          child: Textos(
                                                              'Você não tem receitas',
                                                              'Outfit',
                                                              Color(0xFF57636C),
                                                              14,
                                                              FontWeight.w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8, 8, 8, 8),
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 5,
                                                  color: Color(0x32000000),
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(16, 16, 16, 16),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    Icons.note_alt,
                                                    color: Color(0xFFEE8B60),
                                                    size: 48,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16, 0, 0, 0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Textos(
                                                            'Exames',
                                                            'Outfit',
                                                            Color(0xFF101213),
                                                            22,
                                                            FontWeight.w500),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      4, 0, 0),
                                                          child: Textos(
                                                              'Você não tem Exames',
                                                              'Outfit',
                                                              Color(0xFF57636C),
                                                              14,
                                                              FontWeight.w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.85, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: GradientText(
                    'Serviços',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 32,
                      letterSpacing: 1,
                      fontWeight: FontWeight.normal,
                    ),
                    colors: [Colors.black, Color(0xFF52B788)],
                    gradientDirection: GradientDirection.ttb,
                    gradientType: GradientType.linear,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: Container(
                      height: 50,
                      width: 250,
                      child: botaoTela("Agendar Consulta", Icon(Icons.edit),
                          context, tela_agendamento())),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: Container(
                    height: 50,
                    width: 250,
                    child: botaoTela(
                        "Minhas Consultas",
                        Icon(Icons.calendar_month_outlined),
                        context,
                        Tela_Consultas()),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.85, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: GradientText(
                    'Ajuda',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 32,
                      letterSpacing: 1,
                      fontWeight: FontWeight.normal,
                    ),
                    colors: [Colors.black, Color(0xFF52B788)],
                    gradientDirection: GradientDirection.ttb,
                    gradientType: GradientType.linear,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.1, -1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: Container(
                    height: 50,
                    width: 250,
                    child: botaoTela(
                        "Contatos", Icon(Icons.phone), context, tela_contato()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
