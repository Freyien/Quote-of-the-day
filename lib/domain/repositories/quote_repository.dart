import 'package:phrase_of_the_day/domain/entities/quote_entity.dart';

abstract class QuoteRepository {
  Future<Quote> getQod();
}
