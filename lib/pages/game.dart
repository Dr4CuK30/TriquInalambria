import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triqui_inalambria/components/alertDialogs.dart';
import 'package:triqui_inalambria/mecanics/bot.dart';
import 'package:triqui_inalambria/mecanics/mecanics.dart';
import 'package:triqui_inalambria/utils/model.util.dart';

class PlayerValues {
  static const vacio = "";
  static const j1 = "X";
  static const j2 = "O";
}

String usuario;
bool isDosJugadores;

class Game extends StatefulWidget {
  Game(String usuarioIn, bool isMultijugador) {
    usuario = usuarioIn;
    isDosJugadores = isMultijugador;
  }

  @override
  _State createState() => _State();
}

class _State extends State<Game> {
  int puntuacion;
  int pj1;
  int pj2;
  List<List<String>> tablero;
  String turno = PlayerValues.j1;

  @override
  void initState() {
    puntuacion = 0;
    pj1 = 0;
    pj2 = 0;
    inicializarCeldasVacias();
  }

  void inicializarCeldasVacias() => setState(() => tablero =
      List.generate(3, (_) => List.generate(3, (_) => PlayerValues.vacio)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              AlertDialogs.alertaSalida(context);
            },
            child: Icon(Icons.chevron_left),
            backgroundColor: Colors.orange),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getSistemaPuntuacion(),
              Divider(
                height: 20,
                color: Colors.transparent,
              ),
              ...Modelo.getModelo(tablero, (index, model) => hacerFila(index)),
            ],
          ),
        )));
  }

  Widget hacerFila(int indexX) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: Modelo.getModelo(
            tablero[indexX], (indexY, valor) => hacerCasilla(indexX, indexY)),
      );

  Widget hacerCasilla(int indexX, indexY) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double tam = 0;
    if (width > height)
      tam = height;
    else
      tam = width;
    return getCasillaStyle(indexX, indexY, tam);
  }

  Widget getCasillaStyle(x, y, tam) {
    Color colorx = Colors.white;
    String value = tablero[x][y];
    if (value == "X") {
      colorx = Colors.green;
    } else if (value == "O") {
      colorx = Colors.red;
    }
    return Container(
      margin: EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: () {
          if (turno == PlayerValues.j1 || isDosJugadores) {
            setState(() {
              seleccionarCasilla(x, y);
            });
          }
        },
        child: Text(
          value.toString(),
          style: TextStyle(fontSize: tam / 4.5, fontFamily: "Happy"),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
            primary: colorx, minimumSize: Size(tam / 3 - 40, tam / 3 - 40)),
      ),
    );
  }

  void seleccionarCasilla(int x, int y) async {
    if (tablero[x][y] != PlayerValues.vacio) return;
    tablero[x][y] = turno;
    if (Mecanicas.hayGanador(tablero, x, y)) {
      if (turno == PlayerValues.j1) {
        if (!isDosJugadores) puntuacion += 5;
        pj1++;
        await AlertDialogs.repetirPartida(
            context, "Victoria Jugador 1", usuario, puntuacion, isDosJugadores);
      } else if (turno == PlayerValues.j2) {
        if (!isDosJugadores)
          await AlertDialogs.derrotaDialog(context, usuario, puntuacion);
        else {
          pj2++;
          await AlertDialogs.repetirPartida(context, "Victoria Jugador 2",
              usuario, puntuacion, isDosJugadores);
        }
      }
      inicializarCeldasVacias();
    } else if (Mecanicas.terminoJuego(tablero)) {
      if (isDosJugadores) puntuacion++;
      await AlertDialogs.repetirPartida(
          context, "Empate", usuario, puntuacion, isDosJugadores);
      inicializarCeldasVacias();
    }
    if (turno == PlayerValues.j1) {
      turno = PlayerValues.j2;
      if (!isDosJugadores) {
        Move jugada = Jugada.getRespuestaBot(tablero);
        seleccionarCasilla(jugada.row, jugada.col);
      }
    } else {
      turno = PlayerValues.j1;
    }
  }

  Widget getSistemaPuntuacion() {
    if (!isDosJugadores) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Puntuacion: ",
            style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          Text(
            '$puntuacion',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Jugador 1: $pj1",
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          VerticalDivider(
            width: 40,
          ),
          Text(
            "Jugador 2: $pj2",
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ],
      );
    }
  }
}
