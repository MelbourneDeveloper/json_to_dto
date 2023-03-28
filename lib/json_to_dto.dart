library json_to_dto;

String generateClasses(String className, Map<String, dynamic> jsonMap) {
  final buffer = StringBuffer()..writeln();
  final generatedClasses = <String>{};

  _generateClass(buffer, className, jsonMap, generatedClasses);

  return buffer.toString();
}

void _generateClass(StringBuffer buffer, String className,
    Map<String, dynamic> jsonMap, Set<String> generatedClasses) {
  if (generatedClasses.contains(className)) return;

  generatedClasses.add(className);

  buffer.writeln('class $className {');

  jsonMap.forEach((key, value) {
    final type = getType(value, key);
    buffer.writeln('  final $type? $key;');
  });

  // Unnamed constructor
  buffer
    ..writeln()
    ..writeln('  $className({')
    ..writeAll(jsonMap.entries.map((e) => 'this.${e.key}, '), '')
    ..writeln('});')
    ..writeln();

  // fromJson factory method
  buffer
    ..writeln()
    ..writeln('  factory $className.fromJson(Map<String, dynamic> json) {')
    ..writeln('    return $className(')
    ..writeAll(jsonMap.entries.map((e) {
      final type = getType(e.value, e.key);
      if (type.startsWith('List<')) {
        return '      ${e.key}: (json[\'${e.key}\'] as List<dynamic>?)?.map((e) => ${type.substring(5, type.length - 1)}.fromJson(e as Map<String, dynamic>)).toList(),';
      } else if (e.value is Map) {
        return '      ${e.key}: json[\'${e.key}\'] !=null ? ${getType(e.value, e.key)}.fromJson(json[\'${e.key}\'] as Map<String, dynamic>) : null,';
      } else {
        return '      ${e.key}: json[\'${e.key}\'] != null ? json[\'${e.key}\'] as ${getType(e.value, e.key)}? : null,';
      }
    }), '')
    ..writeln('    );')
    ..writeln('  }');

  // toJson method
  buffer
    ..writeln()
    ..writeln('  Map<String, dynamic> toJson() {')
    ..writeln('    return {')
    ..writeAll(jsonMap.entries.map((e) {
      final type = getType(e.value, e.key);
      if (type.startsWith('List<')) {
        return '      \'${e.key}\': ${e.key}?.map((e) => e.toJson()).toList(),';
      } else if (e.value is Map) {
        return '      \'${e.key}\': ${e.key}?.toJson(),';
      } else {
        return '      \'${e.key}\': ${e.key},';
      }
    }), '')
    ..writeln('    };')
    ..writeln('  }')
    ..writeln('}');

  jsonMap.forEach((key, value) {
    if (value is Map<String, dynamic>) {
      _generateClass(buffer, getType(value, key), value, generatedClasses);
    } else if (value is List) {
      if (value.isNotEmpty && value.first is Map) {
        _generateClass(
            buffer, getType(value.first, key), value.first, generatedClasses);
      }
      value.forEach((element) {
        if (element is Map<String, dynamic>) {
          _generateClass(
              buffer, getType(element, key), element, generatedClasses);
        }
      });
    }
  });
}

String getType(dynamic value, String key) {
  if (value is int) {
    return 'int';
  } else if (value is double) {
    return 'double';
  } else if (value is String) {
    return 'String';
  } else if (value is bool) {
    return 'bool';
  } else if (value is List) {
    if (value.isEmpty) {
      return 'List<dynamic>';
    } else {
      return 'List<${getType(value.first, key)}>';
    }
  } else if (value is Map) {
    return capitalize(key);
  } else {
    return 'dynamic';
  }
}

String capitalize(String s) {
  return s[0].toUpperCase() + s.substring(1);
}