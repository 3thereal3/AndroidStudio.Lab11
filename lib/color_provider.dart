import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier {
  double _red = 0.0;
  double _green = 0.0;
  double _blue = 0.0;

  double get red => _red;
  double get green => _green;
  double get blue => _blue;

  Color get color => Color.fromRGBO(
    _red.toInt(),
    _green.toInt(),
    _blue.toInt(),
    1.0,
  );

  void updateRed(double value) {
    _red = value;
    notifyListeners();
  }

  void updateGreen(double value) {
    _green = value;
    notifyListeners();
  }

  void updateBlue(double value) {
    _blue = value;
    notifyListeners();
  }
}
