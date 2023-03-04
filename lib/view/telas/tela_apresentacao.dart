import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'tela_inicial.dart';
import 'dart:async';

class tela_apresentacao extends StatefulWidget {
  const tela_apresentacao({Key? key}) : super(key: key);

  @override
  State<tela_apresentacao> createState() => _tela_apresentacaoState();
}

class _tela_apresentacaoState extends State<tela_apresentacao> {
  bool _loading = false;
  double _progressValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: corpo(context),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateProgress();
    _loading = !_loading;
    trocar(context);
  }

  Widget corpo(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            imagemFundo(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(58, 220, 0, 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_hospital_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 100)),
                      textoPrincipal("iHealth"),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      child: LinearProgressIndicator(
                        minHeight: 2,
                        backgroundColor: Color.fromARGB(50, 18, 18, 20),
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 0, 247, 255)),
                        value: _progressValue,
                      ),
                      width: 280,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  imagemFundo() {
    return Image.asset(
      "assets/imagens/background.jpg",
      fit: BoxFit.fitHeight,
      height: 533,
    );
  }

  textoPrincipal(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 80, color: Colors.white, fontFamily: 'Love'),
      ),
    );
  }

  void _updateProgress() {
    const oneSec = const Duration(milliseconds: 300);
    // ignore: unnecessary_new
    new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.2;
        if (_progressValue >= 1.0) {
          _loading = false;
          t.cancel();
          return;
        }
      });
    });
  }

  void trocar(context) {
    Future.delayed(Duration(seconds: 5), () {}).then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => TelaInicial())));
  }
}
