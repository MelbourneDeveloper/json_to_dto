import 'dart:convert';

import 'package:json_to_dto/json_to_dto.dart';
import 'package:test/test.dart';

import 'book.dart';
import 'books_json.dart';
import 'person.dart';

const jsonString =
    '{"name": "John", "age": 30, "isMarried": false, "height": 1.75, "children": [{"name": "Alice", "children" : [{"name":"Tim"}]}, {"name": "Bob"}], "address": {"street": "Main Street", "number": 123}}';

const testScoreCode = '''

class TestScore {
  final int? test;

  TestScore({
this.test, });


  factory TestScore.fromJson(Map<String, dynamic> json) {
    return TestScore(
      test: json['test'] != null ? json['test'] as int? : null,    );
  }

  Map<String, dynamic> toJson() {
    return {
      'test': test,    };
  }
}
''';

void main() {
  group('A group of tests', () {
    test('Test Generation', () {
      final decode = json.decode(jsonString) as Map<String, dynamic>;
      final code = decode.toDtoDart('Person');
      expect(code, example);
    });

    test('Test toDtoDart', () {
      final code = <String, dynamic>{'test': 123}.toDtoDart('TestScore');

      expect(code, testScoreCode);
    });

    test('Test toDtoDart from String', () {
      final code = '{ "test" : 123 }'.toDtoDart('TestScore');

      expect(code, testScoreCode);
    });

    test('Test Generated Model', () {
      //Put it through the ringer
      var map = json.decode(jsonString) as Map<String, dynamic>;
      var person = Person.fromJson(map);
      map = person.toJson();
      person = Person.fromJson(map);

      expect(person.name, 'John');
      expect(person.age, 30);
      expect(person.isMarried, false);
      expect(person.height, 1.75);
      expect(person.children!.length, 2);
      expect(person.children![0].name, 'Alice');
      expect(person.children![0].children!.length, 1);
      expect(person.children![0].children![0].name, 'Tim');
      expect(person.children![1].name, 'Bob');
      expect(person.address!.street, 'Main Street');
      expect(person.address!.number, 123);
    });

    test('Test Book DTO', () async {
      final decode = json.decode(booksJson) as Map<String, dynamic>;

      //final code = decode.toDtoDart('Book');

      final book = Book.fromJson(decode);

      final map = book.toJson();

      final secondBook = Book.fromJson(map);

      expect(secondBook.books![0].title, 'The Catcher in the Rye');

      //await File('book.dart').writeAsString(code);
    });
  });
}

const example = '''

class Person {
  final String? name;
  final int? age;
  final bool? isMarried;
  final double? height;
  final List<Children>? children;
  final Address? address;

  Person({
this.name, this.age, this.isMarried, this.height, this.children, this.address, });


  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'] != null ? json['name'] as String? : null,      age: json['age'] != null ? json['age'] as int? : null,      isMarried: json['isMarried'] != null ? json['isMarried'] as bool? : null,      height: json['height'] != null ? json['height'] as double? : null,      children: (json['children'] as List<dynamic>?)?.map((e) => Children.fromJson(e as Map<String, dynamic>)).toList(),      address: json['address'] !=null ? Address.fromJson(json['address'] as Map<String, dynamic>) : null,    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,      'age': age,      'isMarried': isMarried,      'height': height,      'children': children?.map((e) => e.toJson()).toList(),      'address': address?.toJson(),    };
  }
}
class Children {
  final String? name;
  final List<Children>? children;

  Children({
this.name, this.children, });


  factory Children.fromJson(Map<String, dynamic> json) {
    return Children(
      name: json['name'] != null ? json['name'] as String? : null,      children: (json['children'] as List<dynamic>?)?.map((e) => Children.fromJson(e as Map<String, dynamic>)).toList(),    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,      'children': children?.map((e) => e.toJson()).toList(),    };
  }
}
class Address {
  final String? street;
  final int? number;

  Address({
this.street, this.number, });


  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] != null ? json['street'] as String? : null,      number: json['number'] != null ? json['number'] as int? : null,    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,      'number': number,    };
  }
}
''';
