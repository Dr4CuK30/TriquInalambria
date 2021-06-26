import 'dart:math';
import 'package:triqui_inalambria/mecanics/mecanics.dart';

class Move {
  int row, col;
}

class Jugada {
  static int evaluate(List<List<String>> tablero) {
    for (int row = 0; row < 3; row++) {
      if (tablero[row][0] == tablero[row][1] &&
          tablero[row][1] == tablero[row][2]) {
        if (tablero[row][0] == "O")
          return 10;
        else if (tablero[row][0] == "X") return -10;
      }
    }
    for (int col = 0; col < 3; col++) {
      if (tablero[0][col] == tablero[1][col] &&
          tablero[1][col] == tablero[2][col]) {
        if (tablero[0][col] == "O")
          return 10;
        else if (tablero[0][col] == "X") return -10;
      }
    }
    if (tablero[0][0] == tablero[1][1] && tablero[1][1] == tablero[2][2]) {
      if (tablero[0][0] == "O")
        return 10;
      else if (tablero[0][0] == "X") return -10;
    }

    if (tablero[0][2] == tablero[1][1] && tablero[1][1] == tablero[2][0]) {
      if (tablero[0][2] == "O")
        return 10;
      else if (tablero[0][2] == "X") return -10;
    }
    if ((tablero[0][2] == tablero[2][0] && tablero[0][2] == "X") ||
        (tablero[0][0] == tablero[2][2] && tablero[0][0] == "X")) {
      if (tablero[1][1] == "O")
        return 5;
      else if (tablero[1][1] == "X") return -5;
    }

    if (tablero[0][0] == tablero[1][1] && tablero[0][0] == "X") {
      if (tablero[2][2] == "O") return 5;
      if (tablero[2][2] == "X") return -5;
    }
    if (tablero[0][2] == tablero[1][1] && tablero[0][2] == "X") {
      if (tablero[2][0] == "O") return 5;
      if (tablero[2][0] == "X") return -5;
    }
    if (tablero[2][2] == tablero[1][1] && tablero[2][2] == "X") {
      if (tablero[0][0] == "O") return 5;
      if (tablero[0][0] == "X") return -5;
    }
    if (tablero[2][0] == tablero[1][1] && tablero[2][0] == "X") {
      if (tablero[0][2] == "O") return 5;
      if (tablero[0][2] == "X") return -5;
    }
  }

  static int minimax(List<List<String>> tablero, int depth, bool isMax) {
    int score = evaluate(tablero);
    if (score == 10 || score == 5) return score;
    if (score == -10 || score == -5) return score;
    if (Mecanicas.terminoJuego(tablero) == false) return 0;
    if (isMax) {
      int best = -1000;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (tablero[i][j] == '') {
            tablero[i][j] = "O";
            best = max(best, minimax(tablero, depth + 1, !isMax));
            tablero[i][j] = '';
          }
        }
      }
      return best;
    } else {
      int best = 1000;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (tablero[i][j] == '') {
            tablero[i][j] = "X";
            best = min(best, minimax(tablero, depth + 1, !isMax));
            tablero[i][j] = '';
          }
        }
      }
      return best;
    }
  }

  static Move getRespuestaBot(List<List<String>> tablero) {
    int bestVal = -1000;
    List<Move> bestMoves = [];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (tablero[i][j] == '') {
          tablero[i][j] = "O";
          int moveVal = minimax(tablero, 0, false);
          tablero[i][j] = '';
          print(moveVal);
          if (moveVal > bestVal) {
            Move bestMove = Move();
            bestMove.row = i;
            bestMove.col = j;
            bestMoves = [bestMove];
            bestVal = moveVal;
          } else if (moveVal == bestVal) {
            Move bestMove = Move();
            bestMove.row = i;
            bestMove.col = j;
            bestMoves.add(bestMove);
          }
        }
      }
    }
    return bestMoves[Random().nextInt(bestMoves.length)];
  }
}
