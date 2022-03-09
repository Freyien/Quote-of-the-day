import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:phrase_of_the_day/domain/entities/quote_entity.dart';
import 'package:phrase_of_the_day/domain/repositories/quote_repository.dart';
import 'package:phrase_of_the_day/domain/usescases/get_qod_usecase.dart';

class MockQuoteRepository extends Mock implements QuoteRepository {}

class MockQuote extends Mock implements Quote {}

void main() {
  late MockQuoteRepository mockQuoteRepository;
  late GetQodUsecase getQodUsecase;

  setUp(() {
    mockQuoteRepository = MockQuoteRepository();
    getQodUsecase = GetQodUsecase(mockQuoteRepository);
  });

  group('call', () {
    test('Should return Quote', () async {
      // Arrange
      when(() => mockQuoteRepository.getQod())
          .thenAnswer((_) async => MockQuote());

      // Act
      final result = await getQodUsecase.call();

      // Assert
      expect(result, isNotNull);
      expect(result, isA<Quote>());
      verify(() => mockQuoteRepository.getQod());
    });

    test('Should throw Exception', () async {
      // Arrange
      when(() => mockQuoteRepository.getQod()).thenThrow(Exception());

      // Act
      // Assert
      expect(
        () async => await getQodUsecase.call(),
        throwsA(isA<Exception>()),
      );
      verify(() => mockQuoteRepository.getQod());
    });
  });
}
