import 'package:dio/dio.dart';
import 'package:phrase_of_the_day/domain/entities/quote_entity.dart';
import 'package:phrase_of_the_day/domain/entities/quote_response_entity.dart';
import 'package:phrase_of_the_day/domain/repositories/quote_repository.dart';

class QuoteRemoteImpl extends QuoteRepository {
  final Dio _client;

  QuoteRemoteImpl(this._client);

  @override
  Future<Quote> getQod() async {
    final response = await _client.get('/qod');

    final quoteResponse = QuoteResponse.fromJson(response.data);
    final quote = quoteResponse.contents.quotes.first;
    return quote;
  }
}
