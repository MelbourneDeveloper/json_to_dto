class Root {
  final List<Books>? books;

  Root({
    this.books,
  });

  factory Root.fromJson(Map<String, dynamic> json) {
    return Root(
      books: (json['books'] as List<dynamic>?)
          ?.map((e) => Books.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'books': books?.map((e) => e.toJson()).toList(),
    };
  }
}

class Books {
  final String? id;
  final String? title;
  final Author? author;
  final List<String>? genres;
  final Publication? publication;

  Books({
    this.id,
    this.title,
    this.author,
    this.genres,
    this.publication,
  });

  factory Books.fromJson(Map<String, dynamic> json) {
    return Books(
      id: json['id'] != null ? json['id'] as String? : null,
      title: json['title'] != null ? json['title'] as String? : null,
      author: json['author'] != null
          ? Author.fromJson(json['author'] as Map<String, dynamic>)
          : null,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => String.fromJson(e as Map<String, dynamic>))
          .toList(),
      publication: json['publication'] != null
          ? Publication.fromJson(json['publication'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author?.toJson(),
      'genres': genres?.map((e) => e.toJson()).toList(),
      'publication': publication?.toJson(),
    };
  }
}

class Author {
  final String? id;
  final String? name;
  final int? birthYear;
  final int? deathYear;

  Author({
    this.id,
    this.name,
    this.birthYear,
    this.deathYear,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'] != null ? json['id'] as String? : null,
      name: json['name'] != null ? json['name'] as String? : null,
      birthYear: json['birthYear'] != null ? json['birthYear'] as int? : null,
      deathYear: json['deathYear'] != null ? json['deathYear'] as int? : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'birthYear': birthYear,
      'deathYear': deathYear,
    };
  }
}

class Publication {
  final String? publisher;
  final int? year;
  final String? edition;
  final String? language;

  Publication({
    this.publisher,
    this.year,
    this.edition,
    this.language,
  });

  factory Publication.fromJson(Map<String, dynamic> json) {
    return Publication(
      publisher:
          json['publisher'] != null ? json['publisher'] as String? : null,
      year: json['year'] != null ? json['year'] as int? : null,
      edition: json['edition'] != null ? json['edition'] as String? : null,
      language: json['language'] != null ? json['language'] as String? : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'publisher': publisher,
      'year': year,
      'edition': edition,
      'language': language,
    };
  }
}
