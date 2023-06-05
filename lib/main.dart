import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Center(child: TextToSpeech()),
        ));
  }
}

class TextToSpeech extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();
  bool next = false;
  bool brk = false;

  TextToSpeech({super.key});

  speak(String text) async {
    final splitted = text.split('.');
    int i = 0;

    brk = false;
    next = false;

    while (!next) {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(0.8); //0.5 to 1.5
      await flutterTts.setSpeechRate(0.5);
      // await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
      await flutterTts.speak(splitted[i]);
      await Future.delayed(const Duration(milliseconds: 2500));
      if (next) {
        i++;
        next = false;
        if (i >= splitted.length) {
          await flutterTts.speak("Thank you for using my services.");
          break;
        }
      }
      if (brk) {
        await flutterTts.speak("Thank you for using my services.");
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            TextFormField(
              controller: textEditingController,
            ),
            ElevatedButton(
              child: const Text("Press to begin speech"),
              onPressed: () => speak(textEditingController.text),
            ),
            ElevatedButton(
              child: const Text("Next"),
              onPressed: () => next = true,
            ),
            ElevatedButton(
              child: const Text("End"),
              onPressed: () => brk = true,
            ),
          ])),
    );
  }
}
