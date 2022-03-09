import 'package:phrase_of_the_day/domain/entities/quote_entity.dart';

class QuoteResponse {
  QuoteResponse({
    required this.contents,
  });

  final Contents contents;

  factory QuoteResponse.fromJson(Map<String, dynamic> json) => QuoteResponse(
        contents: Contents.fromJson(json["contents"]),
      );
}

class Contents {
  Contents({
    required this.quotes,
  });

  final List<Quote> quotes;

  factory Contents.fromJson(Map<String, dynamic> json) => Contents(
        quotes: List<Quote>.from(json["quotes"].map((x) => Quote.fromJson(x))),
      );
}
