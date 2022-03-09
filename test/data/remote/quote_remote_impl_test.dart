import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:phrase_of_the_day/data/remote/quote_remote_impl.dart';
import 'package:phrase_of_the_day/domain/entities/quote_entity.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late QuoteRemoteImpl quoteRemoteImpl;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    quoteRemoteImpl = QuoteRemoteImpl(dio);
  });

  group('getQod', () {
    test('Should return Quote', () async {
      // Arrange
      dioAdapter.onGet(
        '/qod',
        (server) => server.reply(200, {
          "success": "string",
          "contents": {
            "quotes": [
              {
                "author": "string",
                "quote": "string",
                "tags": ["string"],
                "id": "string",
                "image": "string",
                "length": 0
              }
            ]
          }
        }),
      );

      // Act
      final result = await quoteRemoteImpl.getQod();

      // Assert
      expect(result, isNotNull);
      expect(result, isA<Quote>());
    });

    test('Should throw Exception', () async {
      // Arrange
      dioAdapter.onGet(
        '/qod',
        (server) => server.reply(500, {}),
      );

      // Act
      // Assert
      expect(
        () async => await quoteRemoteImpl.getQod(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
