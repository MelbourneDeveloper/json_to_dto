import 'package:code_text_field/code_text_field.dart';
import 'package:example/books_json.dart';
import 'package:flutter/material.dart';
import 'package:json_to_dto/json_to_dto.dart';
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/json.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final CodeController _codeController;

  @override
  void initState() {
    super.initState();

    _codeController = CodeController(
      language: json,
      text: booksJson,
    );
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'JSON to DTO',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            centerTitle: true,
            backgroundColor: Color(0xFF333333),
            elevation: 4.0,
          ),
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: CodeTheme(
                        data: const CodeThemeData(styles: monokaiSublimeTheme),
                        child: CodeField(
                          controller: _codeController,
                          textStyle: const TextStyle(fontFamily: 'SourceCode'),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 90,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _codeController.language = json;
                              _codeController.text = booksJson;
                            });
                          },
                          child: const Text('RESET'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 90,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _codeController.language = dart;
                              _codeController.text =
                                  //This is the magic that converts the JSON to Dart
                                  _codeController.text.toDtoDart();
                            });
                          },
                          child: const Text('GENERATE'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 90,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              launchUrl(Uri.parse(
                                  'https://www.christianfindlay.com'));
                            });
                          },
                          child: const Text('HIRE ME'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
