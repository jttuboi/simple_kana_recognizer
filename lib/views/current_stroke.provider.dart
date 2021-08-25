import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:simple_kana_recognizer/controllers/home.controller.dart';

class CurrentStrokeProvider extends ChangeNotifier {
  CurrentStrokeProvider(this.homeController);

  final HomeController homeController;

  List<Offset> points = [];
  bool _canAdd = true;
  double _startSquareLimit = 0.0;
  double _endSquareLimit = 0.0;

  void setLimit(double startSquareLimit, double endSquareLimit) {
    _startSquareLimit = startSquareLimit;
    _endSquareLimit = endSquareLimit;
    homeController.startSquareLimit = startSquareLimit;
    homeController.endSquareLimit = endSquareLimit;
  }

  void addPoint(Offset point) {
    if (_startSquareLimit < point.dx && point.dx < _endSquareLimit && _startSquareLimit < point.dy && point.dy < _endSquareLimit && _canAdd) {
      points.add(point);
      notifyListeners();
    } else {
      _canAdd = false;
    }
  }

  void resetPoints() {
    points = [];
    _canAdd = true;
    notifyListeners();
  }
}
