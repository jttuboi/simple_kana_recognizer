import 'dart:ui';

import 'package:simple_kana_recognizer/controllers/kana.dart';
import 'package:simple_kana_recognizer/controllers/kana.interface.repository.dart';
import 'package:simple_kana_recognizer/controllers/kana_checker.interface.service.dart';
import 'package:simple_kana_recognizer/controllers/stroke_reducer.interface.service.dart';
import 'package:simple_kana_recognizer/models/kana.repository.dart';
import 'package:simple_kana_recognizer/models/kana_checker.service.dart';
import 'package:simple_kana_recognizer/models/stroke_reducer.service.dart';

class HomeController {
  HomeController() {
    _kanaChecker = KanaCheckerService();
    _strokeReducer = StrokeReducerService(limitPointsToReduce: 20);
    _repository = KanaRepository();
    kanaToWrite = _repository.getRandomKana();
  }

  late final IKanaCheckerService _kanaChecker;
  late final IStrokeReducerService _strokeReducer;
  late final IKanaRepository _repository;

  double startSquareLimit = 0.0;
  double endSquareLimit = 100.0;
  bool _isCorrect = false;
  String _charWrote = '';

  List<List<Offset>> strokes = [];
  late Kana kanaToWrite;

  void addStroke(List<Offset> stroke) {
    strokes.add(_strokeReducer.reduce(stroke));
  }

  void clearStrokes() {
    strokes.clear();
  }

  void undoTheLastStroke() {
    if (strokes.isNotEmpty) {
      strokes.removeLast();
    }
  }

  bool get isTheLastStroke => strokes.length >= kanaToWrite.maxStrokes;

  String get showMessageTop => 'Write: ${kanaToWrite.id}';

  String get showMessageBottom => _isCorrect
      ? 'Wrote correct: $_charWrote'
      : _charWrote.isNotEmpty
          ? 'Wrote wrong: $_charWrote'
          : '';

  void updateKana() {
    final normalizedStrokes = _normalizedStrokes(startSquareLimit, endSquareLimit);
    _isCorrect = _kanaChecker.checkKana(normalizedStrokes, kanaToWrite.id, kanaToWrite.maxStrokes);
    _charWrote = kanaToWrite.id;
    kanaToWrite = _repository.getRandomKana();
    strokes.clear();
  }

  List<List<Offset>> _normalizedStrokes(double startSquareLimit, double endSquareLimit) {
    final strokesNormalized = <List<Offset>>[];
    for (final stroke in strokes) {
      final strokeNormalized = <Offset>[];
      for (final point in stroke) {
        final pointNormalized = Offset(
          (point.dx - startSquareLimit) / (endSquareLimit - startSquareLimit),
          (point.dy - startSquareLimit) / (endSquareLimit - startSquareLimit),
        );
        strokeNormalized.add(pointNormalized);
      }
      strokesNormalized.add(strokeNormalized);
    }

    return strokesNormalized;
  }
}
