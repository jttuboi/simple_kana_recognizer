import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_kana_recognizer/controllers/home.controller.dart';
import 'package:simple_kana_recognizer/views/all_stroke.provider.dart';
import 'package:simple_kana_recognizer/views/buttons.dart';
import 'package:simple_kana_recognizer/views/current_stroke.provider.dart';
import 'package:simple_kana_recognizer/views/message.provider.dart';
import 'package:simple_kana_recognizer/views/writer.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AllStrokesProvider(homeController)),
        ChangeNotifierProvider(create: (context) => CurrentStrokeProvider(homeController)),
        ChangeNotifierProvider(create: (context) => MessageProvider(homeController)),
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: MessageTop(),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                child: Buttons(),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Writer(size: screenWidth - 32.0),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: MessageBottom(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageTop extends StatelessWidget {
  const MessageTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageProvider>(builder: (context, provider, child) {
      return Center(
        child: Text(provider.messageTop, style: const TextStyle(fontSize: 25)),
      );
    });
  }
}

class MessageBottom extends StatelessWidget {
  const MessageBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageProvider>(builder: (context, provider, child) {
      return Center(
        child: Text(provider.messageBottom, style: const TextStyle(fontSize: 25)),
      );
    });
  }
}
