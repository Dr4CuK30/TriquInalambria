import 'package:flutter/material.dart';
import 'package:triqui_inalambria/provider/puntuaciones.provider.dart';

class PuntuacionesScreen extends StatelessWidget {
  List<TableRow> puntuaciones;

  PuntuacionesScreen(List<TableRow> puntuacionesE) {
    puntuaciones = puntuacionesE;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.chevron_left),
            backgroundColor: Colors.orange),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: Container(
      padding: EdgeInsets.all(50),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: RadialGradient(colors: [
          Color(0xff235a7f),
          Color(0xff1f4a6a),
          Color(0xff1b3b56),
          Color(0xff152d43),
          Color(0xff0f1f30)
        ], radius: 1.0),
      ),
      child: Table(
        children: [
          TableRow(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  'Usuario',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                
                margin: EdgeInsets.all(20),
                child: Text(
                  'Puntuación',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          ...puntuaciones
        ],
      ),
    ));
  }
}
