import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../components/navbar.dart';

class tela_contato extends StatefulWidget {
  const tela_contato({Key? key}) : super(key: key);

  @override
  _tela_contatoState createState() => _tela_contatoState();
}

class _tela_contatoState extends State<tela_contato> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appbar(),
      backgroundColor: Colors.white,
      floatingActionButton: botaoFlutuante(),
      body: corpo(context),
        drawer: navbar(),

    );
  }

  corpo(context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: AlignmentDirectional(-0.7, -0.7),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: GradientText(
                    'Nossos Contatos...',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 28,
                      letterSpacing: 1,
                    ),
                    colors: [Colors.black, Color(0xFF1B4332)],
                    gradientDirection: GradientDirection.ltr,
                    gradientType: GradientType.linear,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                child: Container(
                  width: 350,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF95D5B2),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(50),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-0.9, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 50, 0),
                              child: Icon(
                                Icons.phone,
                                color: Color(0xFF081C15),
                                size: 40,
                              ),
                            ),
                          ),
                          Text(
                            '3671 - 5300',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                child: Container(
                  width: 350,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF95D5B2),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(50),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-0.9, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 30, 0),
                              child: Icon(
                                Icons.phone_android_outlined,
                                color: Color(0xFF081C15),
                                size: 40,
                              ),
                            ),
                          ),
                          Text(
                            '(051) 996090800',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                child: Container(
                  width: 350,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF95D5B2),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(50),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-0.9, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                              child: Icon(
                                Icons.alternate_email,
                                color: Color(0xFF081C15),
                                size: 40,
                              ),
                            ),
                          ),
                          Text(
                            'clinicamedica@gmail.com',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                child: Container(
                  width: 350,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF95D5B2),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(50),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-0.9, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                              child: Icon(
                                Icons.business_outlined,
                                color: Color(0xFF081C15),
                                size: 40,
                              ),
                            ),
                          ),
                          Text(
                            'Av. Presidenta Vargas, 668',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                child: Container(
                  width: 350,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF95D5B2),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(50),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-0.9, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                              child: Icon(
                                Icons.screen_search_desktop_rounded,
                                color: Color(0xFF081C15),
                                size: 40,
                              ),
                            ),
                          ),
                          Text(
                            'www.clinicamedica.com',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Text(
                    'Para mais informações visite nosso site',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  appbar() {
    return AppBar(
      backgroundColor: Color(0xFF40916C),
      automaticallyImplyLeading: true,
      title: Text(
        'Contatos',
        style: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.white,
          fontSize: 22,
          letterSpacing: 1,
        ),
      ),
      actions: [],
      centerTitle: false,
      elevation: 2,
    );
  }

  botaoFlutuante() {
    return FloatingActionButton(
      child: Icon(Icons.whatsapp),
      onPressed: () {
        print('FloatingActionButton pressed ...');
      },
      backgroundColor: Colors.green,
    );
  }
}
