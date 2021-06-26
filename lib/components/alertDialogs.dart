import 'package:flutter/material.dart';
import 'package:triqui_inalambria/provider/puntuaciones.provider.dart';

class AlertDialogs {
  static Future<void> alertaSalida(BuildContext gameContext) async {
    return showDialog<void>(
      context: gameContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿En verdad desea salir?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Si sale, perdera todo el progreso del juego.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: const Text('Salir'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(gameContext).pop();
                }),
          ],
        );
      },
    );
  }

  static Future<void> repetirPartida(BuildContext gameContext, String msg,
      String usuario, int puntuacion, bool isDosJugadores) async {
    return showDialog<void>(
      context: gameContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('¿Desea continuar el juego?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Salir', style: TextStyle(color: Colors.red)),
              onPressed: () {
                if(isDosJugadores) PuntuacionesProvider().submitPuntuacion(usuario, puntuacion);
                Navigator.of(context).pop();
                Navigator.of(gameContext).pop();
              },
            ),
            TextButton(
                child: const Text(
                  'Continuar',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  static Future<void> derrotaDialog(
      BuildContext gameContext, String usuario, int puntuacion) async {
    return showDialog<void>(
      context: gameContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Derrota"),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Oprima salir para volver al menu principal'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Salir', style: TextStyle(color: Colors.red)),
              onPressed: () {
                PuntuacionesProvider().submitPuntuacion(usuario, puntuacion);
                Navigator.of(context).pop();
                Navigator.of(gameContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
