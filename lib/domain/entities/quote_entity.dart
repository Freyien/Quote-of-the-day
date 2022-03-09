class Quote {
  Quote({
    required this.quote,
    required this.id,
    this.author = 'Autor desconocido',
    this.background,
  });

  final String quote;
  final String author;
  final String id;
  final String? background;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        quote: json["quote"],
        author: json["author"],
        id: json["id"],
        background: json["background"],
      );
}
