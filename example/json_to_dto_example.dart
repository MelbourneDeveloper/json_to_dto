import 'dart:convert';
import 'dart:io';

import 'package:json_to_dto/json_to_dto.dart';

const jsonString =
    '{"name": "John", "age": 30, "isMarried": false, "height": 1.75,'
    ' "children": [{"name": "Alice", "children" : [{"name":"Tim"}]},'
    ' {"name": "Bob"}], "address": {"street": "Main Street", "number": 123}}';

void main() {
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  final code = generateClasses('Person', jsonMap);

  File('person.dart').writeAsStringSync(code);
}
