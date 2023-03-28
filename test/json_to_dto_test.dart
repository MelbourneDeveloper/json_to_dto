import 'dart:convert';

import 'package:json_to_dto/json_to_dto.dart';
import 'package:test/test.dart';

const jsonString =
    '{"name": "John", "age": 30, "isMarried": false, "height": 1.75, "children": [{"name": "Alice", "children" : [{"name":"Tim"}]}, {"name": "Bob"}], "address": {"street": "Main Street", "number": 123}}';

void main() {
  group('A group of tests', () {
    test('First Test', () {
      final code = generateClasses(
          'Person', json.decode(jsonString) as Map<String, dynamic>);
      expect(code.length, 2068);
    });
  });
}
