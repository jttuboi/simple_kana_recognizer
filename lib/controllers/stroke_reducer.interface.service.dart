import 'dart:ui';

abstract class IStrokeReducerService {
  List<Offset> reduce(List<Offset> stroke);
}
