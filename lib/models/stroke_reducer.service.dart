import 'dart:collection';
import 'dart:ui';

import 'package:simple_kana_recognizer/controllers/stroke_reducer.interface.service.dart';

class StrokeReducerService implements IStrokeReducerService {
  StrokeReducerService({required this.limitPointsToReduce});

  final int limitPointsToReduce;

  @override
  List<Offset> reduce(List<Offset> stroke) {
    if (stroke.length <= limitPointsToReduce) {
      return stroke;
    }

    // it's using ramer douglas peucker algorithm to reduce polyline with different limitDistance
    List<Offset> newStroke = _reducerPolylineRamerDouglasPeuckerStack(stroke, 0.5);
    if (newStroke.length > limitPointsToReduce) {
      newStroke = _reducerPolylineRamerDouglasPeuckerStack(stroke, 1.0);
    }
    if (newStroke.length > limitPointsToReduce) {
      newStroke = _reducerPolylineRamerDouglasPeuckerStack(stroke, 2.0);
    }
    return newStroke;
  }

  // https://gist.github.com/Snegovikufa/6490663
  List<Offset> _reducerPolylineRamerDouglasPeuckerStack(List<Offset> points, double limitDistance) {
    final length = points.length;
    final markers = List.filled(length, false);

    int firstIndex = 0;
    int lastIndex = length - 1;
    int index = -1;

    final firstStack = Queue<int>();
    final lastStack = Queue<int>();
    final newPoints = <Offset>[];

    // marca posições do primeiro e último
    markers[firstIndex] = markers[lastIndex] = true;

    while (lastIndex != -1) {
      // procura pelo segmento que contém a máxima distancia perpendicular
      double maxDistance = 0;
      for (int i = firstIndex + 1; i < lastIndex; i++) {
        final squareSegmentDistance = _getSquareSegmentDistance(points[i], points[firstIndex], points[lastIndex]);
        if (squareSegmentDistance > maxDistance) {
          index = i;
          maxDistance = squareSegmentDistance;
        }
      }

      // se o segmento passar da distancia limite
      if (maxDistance > limitDistance) {
        // marca esse segmento
        markers[index] = true;

        // divide em 2 partes, colocando-os no stack
        firstStack.add(firstIndex);
        lastStack.add(index);

        firstStack.add(index);
        lastStack.add(lastIndex);
      }

      // atualiza os indexs e caso não aja mais index, finaliza-os
      firstIndex = firstStack.isNotEmpty ? firstStack.removeLast() : -1;
      lastIndex = lastStack.isNotEmpty ? lastStack.removeLast() : -1;
    }

    // se não foi marcado, o ponto que permanecerá na lista final intocado
    for (int i = 0; i < length; i++) {
      if (markers[i]) {
        newPoints.add(points[i]);
      }
    }
    return newPoints;
  }

  double _getSquareSegmentDistance(Offset point, Offset firstPoint, Offset lastPoint) {
    double x = firstPoint.dx;
    double y = firstPoint.dy;

    double dx = lastPoint.dx - x;
    double dy = lastPoint.dy - y;

    if (dx != 0 || dy != 0) {
      final t = ((point.dx - x) * dx + (point.dy - y) * dy) / (dx * dx + dy * dy);

      if (t > 1) {
        x = lastPoint.dx;
        y = lastPoint.dy;
      } else if (t > 0) {
        x += dx * t;
        y += dy * t;
      }
    }

    dx = point.dx - x;
    dy = point.dy - y;

    return dx * dx + dy * dy;
  }
}
