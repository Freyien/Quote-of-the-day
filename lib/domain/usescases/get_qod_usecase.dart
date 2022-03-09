import 'package:phrase_of_the_day/domain/entities/quote_entity.dart';
import 'package:phrase_of_the_day/domain/repositories/quote_repository.dart';

class GetQodUsecase {
  final QuoteRepository _quoteRepository;

  GetQodUsecase(this._quoteRepository);

  Future<Quote> call() async {
    return await _quoteRepository.getQod();
  }
}
