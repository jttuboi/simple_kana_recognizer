import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_kana_recognizer/views/all_stroke.provider.dart';

class Buttons extends StatelessWidget {
  const Buttons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _Button('Clear', onPressed: () => _clearStrokes(context)),
        _Button('Undo', onPressed: () => _undoStroke(context)),
      ],
    );
  }

  void _clearStrokes(BuildContext context) {
    final allProvider = Provider.of<AllStrokesProvider>(context, listen: false);
    allProvider.clearStrokes();
  }

  void _undoStroke(BuildContext context) {
    final allProvider = Provider.of<AllStrokesProvider>(context, listen: false);
    allProvider.undoTheLastStroke();
  }
}

class _Button extends StatelessWidget {
  const _Button(this.title, {Key? key, required this.onPressed}) : super(key: key);

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(30))),
      child: Text(title, style: const TextStyle(fontSize: 18)),
    );
  }
}
