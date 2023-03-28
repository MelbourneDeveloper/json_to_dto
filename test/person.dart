class Person {
  final String? name;
  final int? age;
  final bool? isMarried;
  final double? height;
  final List<Children>? children;
  final Address? address;

  Person({
    this.name,
    this.age,
    this.isMarried,
    this.height,
    this.children,
    this.address,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'] != null ? json['name'] as String? : null,
      age: json['age'] != null ? json['age'] as int? : null,
      isMarried: json['isMarried'] != null ? json['isMarried'] as bool? : null,
      height: json['height'] != null ? json['height'] as double? : null,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => Children.fromJson(e as Map<String, dynamic>))
          .toList(),
      address: json['address'] != null
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'isMarried': isMarried,
      'height': height,
      'children': children?.map((e) => e.toJson()).toList(),
      'address': address?.toJson(),
    };
  }
}

class Children {
  final String? name;
  final List<Children>? children;

  Children({
    this.name,
    this.children,
  });

  factory Children.fromJson(Map<String, dynamic> json) {
    return Children(
      name: json['name'] != null ? json['name'] as String? : null,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => Children.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'children': children?.map((e) => e.toJson()).toList(),
    };
  }
}

class Address {
  final String? street;
  final int? number;

  Address({
    this.street,
    this.number,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] != null ? json['street'] as String? : null,
      number: json['number'] != null ? json['number'] as int? : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'number': number,
    };
  }
}
