import 'package:flutter/material.dart';

class Modelo {
  static List<Widget> getModelo<Cas>(List<Cas> models, Widget Function(int index, Cas model) builder) =>
      models
          .asMap()
          .map<int, Widget>(
              (index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();
}
