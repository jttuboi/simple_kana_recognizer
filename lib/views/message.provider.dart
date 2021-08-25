import 'package:flutter/foundation.dart';
import 'package:simple_kana_recognizer/controllers/home.controller.dart';

class MessageProvider extends ChangeNotifier {
  MessageProvider(this._controller);

  final HomeController _controller;

  String get messageTop => _controller.showMessageTop;

  String get messageBottom => _controller.showMessageBottom;

  bool get isTheLastStroke => _controller.isTheLastStroke;

  String get kanaId => _controller.kanaToWrite.id;

  void updateMessage() {
    // if calling to update message, so all the strokes are drawn
    _controller.updateKana();
    notifyListeners();
  }
}
