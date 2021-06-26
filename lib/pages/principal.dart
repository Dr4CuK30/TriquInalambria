import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:triqui_inalambria/pages/game.dart';
import 'package:triqui_inalambria/pages/puntuaciones.dart';
import 'package:triqui_inalambria/provider/puntuaciones.provider.dart';

class Principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final border = [
      Shadow(offset: Offset(-1.5, -1.5), color: Colors.black),
      Shadow(offset: Offset(1.5, -1.5), color: Colors.black),
      Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
      Shadow(offset: Offset(-1.5, 1.5), color: Colors.black),
    ];
    return Scaffold(
        body: Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(colors: [
            Color(0xff235a7f),
            Color(0xff1f4a6a),
            Color(0xff1b3b56),
            Color(0xff152d43),
            Color(0xff0f1f30)
          ], radius: 1.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Triqu",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 65,
                        fontFamily: "Imstory",
                        shadows: border),
                  ),
                  Text(
                    "Inalambria",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 50,
                        fontFamily: "Imstory",
                        shadows: border),
                  )
                ],
              ),
              Divider(
                height: 150,
                color: Colors.transparent,
              ),
              Container(
                width: 200,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(hintText: "Nombre de Usuario"),
                  cursorColor: Colors.orange,
                  style: TextStyle(color: Colors.white),
                  controller: usernameController,
                ),
              ),
              Divider(
                height: 20,
                color: Colors.transparent,
              ),
              SuccessButton(title: "Iniciar Juego", onPressed: () {
                cargarJuego(context, usernameController.text.trim(), false);
              }),
              DangerButton(title: "Dos Jugadores", onPressed: () {
                cargarJuego(context, usernameController.text.trim(), true);
              }),
              WarningButton(
                title: "Puntuaciones",
                onPressed: () async {
                  List<TableRow> puntuaciones = await getPuntuaciones();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PuntuacionesScreen(puntuaciones)));
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<List<TableRow>> getPuntuaciones() async {
    List<TableRow> rows = [];
    final regs = await PuntuacionesProvider().getPuntuaciones();
    for (Map reg in regs) {
      rows.add(TableRow(children: [
        Container(
            margin: EdgeInsets.all(10),
            child: Text(
              reg['usuario'],
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            )),
        Container(
          margin: EdgeInsets.all(8),
          child: Text(
            '${reg['puntuacion']}',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ]));
    }
    return rows;
  }

  cargarJuego(BuildContext context, String username,bool isMulti) {
    if (username.length != 0 || isMulti) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Game(username, isMulti)));
    }
  }
}
