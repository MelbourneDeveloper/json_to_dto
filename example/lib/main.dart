import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:json_to_dto/json_to_dto.dart';
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/json.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

var initialJson = '{ "test" : 123 }';

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
      text: initialJson,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
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
                            _codeController.text = initialJson;
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
