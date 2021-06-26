
class Mecanicas {
  static hayGanador(List<List<String>> tablero, int x, int y) {
    var col = 0, fila = 0, diag = 0, odiag = 0;
    final player = tablero[x][y];

    for (int i = 0; i < 3; i++) {
      if (tablero[i][y] == player) fila++;
      if (tablero[x][i] == player) col++;
      if (tablero[i][i] == player) diag++;
      if (tablero[i][3 - i - 1] == player) odiag++;
    }

    return fila == 3 || col == 3 || diag == 3 || odiag == 3;
  }

  static bool terminoJuego(List<List<String>> tablero) {
    for (int x = 0; x < 3; x++) {
      for (int y = 0; y < 3; y++) {
        if (tablero[x][y] == "") return false;
      }
    }
    return true;
  }

}


