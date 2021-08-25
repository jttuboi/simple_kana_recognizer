import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_kana_recognizer/views/all_stroke.provider.dart';
import 'package:simple_kana_recognizer/views/border_painter.dart';
import 'package:simple_kana_recognizer/views/current_stroke.provider.dart';
import 'package:simple_kana_recognizer/views/message.provider.dart';

class Writer extends StatelessWidget {
  const Writer({Key? key, required this.size}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.grey[200], height: size, width: size),
        CustomPaint(painter: BorderPainter(), size: Size.square(size)),
        SizedBox(
          height: size,
          width: size,
          child: Consumer<MessageProvider>(
            builder: (context, provider, child) {
              return FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(provider.kanaId, style: const TextStyle(fontFamily: 'Kanji Stroke Orders', fontSize: 350)),
              );
            },
          ),
        ),
        SizedBox(
          height: size,
          width: size,
          child: Consumer<AllStrokesProvider>(
            builder: (context, provider, child) {
              return RepaintBoundary(
                child: CustomPaint(isComplex: true, painter: _AllStrokesPainter(provider.strokes)),
              );
            },
          ),
        ),
        SizedBox(
          height: size,
          width: size,
          child: GestureDetector(
            onPanStart: (details) => _startStroke(details, context, size),
            onPanUpdate: (details) => _updateStroke(details, context),
            onPanEnd: (details) => _finishStroke(context),
            child: Consumer<CurrentStrokeProvider>(
              builder: (context, provider, child) {
                return RepaintBoundary(
                  child: CustomPaint(
                    isComplex: true,
                    painter: _CurrentStrokePainter(provider.points),
                    child: child,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _startStroke(DragStartDetails details, BuildContext context, double size) {
    const paddingForWriter = 16.0;
    final currentStrokeProvider = Provider.of<CurrentStrokeProvider>(context, listen: false);
    currentStrokeProvider.setLimit(paddingForWriter, size - paddingForWriter);
    currentStrokeProvider.addPoint(details.localPosition);
  }

  void _updateStroke(DragUpdateDetails details, BuildContext context) {
    final currentStrokeProvider = Provider.of<CurrentStrokeProvider>(context, listen: false);
    currentStrokeProvider.addPoint(details.localPosition);
  }

  void _finishStroke(BuildContext context) {
    final currentStrokeProvider = Provider.of<CurrentStrokeProvider>(context, listen: false);
    final allStrokeProvider = Provider.of<AllStrokesProvider>(context, listen: false);
    final messageProvider = Provider.of<MessageProvider>(context, listen: false);
    allStrokeProvider.addStroke(currentStrokeProvider.points);
    currentStrokeProvider.resetPoints();
    if (messageProvider.isTheLastStroke) {
      messageProvider.updateMessage();
    }
  }
}

class _AllStrokesPainter extends CustomPainter {
  const _AllStrokesPainter(this.strokes);

  final List<List<Offset>> strokes;

  @override
  void paint(Canvas canvas, Size size) {
    final allStrokePaint = Paint()
      ..strokeWidth = 16.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = Colors.black;

    for (final points in strokes) {
      canvas.drawPoints(PointMode.polygon, points, allStrokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _CurrentStrokePainter extends CustomPainter {
  const _CurrentStrokePainter(this.points);

  final List<Offset> points;

  @override
  void paint(Canvas canvas, Size size) {
    final currentStrokePaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 18.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = Colors.black.withOpacity(0.9);

    canvas.drawPoints(PointMode.polygon, points, currentStrokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
