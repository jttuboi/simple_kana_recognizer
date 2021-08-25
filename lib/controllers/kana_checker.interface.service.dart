import 'dart:ui';

abstract class IKanaCheckerService {
  bool checkKana(List<List<Offset>> normalizedStrokes, String kana, int maxStrokes);
}
