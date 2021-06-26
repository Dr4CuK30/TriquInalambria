import 'package:flutter/material.dart';
import 'package:triqui_inalambria/pages/game.dart';
import 'package:triqui_inalambria/pages/principal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TriquInalambria',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Principal(),
    );
  }
}
