import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:phrase_of_the_day/domain/entities/quote_entity.dart';
import 'package:phrase_of_the_day/presentation/bloc/qod/qod_bloc.dart';
import 'package:phrase_of_the_day/presentation/pages/qod_page.dart';

class MockQodBloc extends MockBloc<QodEvent, QodState> implements QodBloc {}

void main() {
  const author = "Fernando Luis Martínez";
  const quoteText = "Aquí iría una buena frase motivaciones si tuviera una";

  late MockQodBloc mockQodBloc;
  late Quote quote;

  setUp(() {
    mockQodBloc = MockQodBloc();
    quote = Quote.fromJson({
      "author": author,
      "quote": quoteText,
      "tags": ["string"],
      "id": "string",
      "background":
          "https://i.pinimg.com/736x/91/4c/8a/914c8ad918ebadc9b8a23a18bd592c6d.jpg",
      "length": 0
    });
  });

  group('QodPage', () {
    testWidgets('Show Loading when LoadingState is emitted', (tester) async {
      // Arrange
      when(() => mockQodBloc.state).thenReturn(LoadingState());

      // Act
      await tester.pumpWidget(
        BlocProvider<QodBloc>.value(
          value: mockQodBloc,
          child: const MaterialApp(
            home: QodView(),
          ),
        ),
      );

      // Assert
      expect(find.byKey(const Key('loading')), findsOneWidget);
    });

    testWidgets('Show ErrorMessage when FailedState is emitted',
        (tester) async {
      // Arrange
      when(() => mockQodBloc.state).thenReturn(FailedState());

      // Act
      await tester.pumpWidget(
        BlocProvider<QodBloc>.value(
          value: mockQodBloc,
          child: const MaterialApp(
            home: QodView(),
          ),
        ),
      );

      // Assert
      expect(find.byKey(const Key('errorMessage')), findsOneWidget);
    });

    testWidgets('Show _QOD when FailedState is emitted', (tester) async {
      // Arrange
      when(() => mockQodBloc.state).thenReturn(SuccessState(quote));

      // Act
      await tester.pumpWidget(
        BlocProvider<QodBloc>.value(
          value: mockQodBloc,
          child: const MaterialApp(
            home: QodView(),
          ),
        ),
      );

      // Assert
      expect(find.byKey(const Key('Qod')), findsOneWidget);
    });
  });

  group('BackgroundImage', () {
    testWidgets('Show image from url', (tester) async {
      // Arrange
      when(() => mockQodBloc.state).thenReturn(SuccessState(quote));

      // Act
      await tester.pumpWidget(
        BlocProvider<QodBloc>.value(
          value: mockQodBloc,
          child: const MaterialApp(
            home: QodView(),
          ),
        ),
      );

      // Assert
      expect(find.byKey(const Key('backgroundUrlImage')), findsOneWidget);
    });

    testWidgets('Show local image when background is null', (tester) async {
      // Arrange
      final newQuote = Quote(quote: 'quote', id: 'id');
      when(() => mockQodBloc.state).thenReturn(SuccessState(newQuote));

      // Act
      await tester.pumpWidget(
        BlocProvider<QodBloc>.value(
          value: mockQodBloc,
          child: const MaterialApp(
            home: QodView(),
          ),
        ),
      );

      // Assert
      expect(find.byKey(const Key('backgroundLocalImage')), findsOneWidget);
      expect(find.byKey(const Key('backgroundUrlImage')), findsNothing);
    });
  });

  group('Quote', () {
    testWidgets('Should show the author', (tester) async {
      // Arrange
      when(() => mockQodBloc.state).thenReturn(SuccessState(quote));

      // Act
      await tester.pumpWidget(
        BlocProvider<QodBloc>.value(
          value: mockQodBloc,
          child: const MaterialApp(
            home: QodView(),
          ),
        ),
      );

      // Assert
      expect(find.text(author), findsOneWidget);
    });

    testWidgets('Should show the quote message', (tester) async {
      // Arrange
      when(() => mockQodBloc.state).thenReturn(SuccessState(quote));

      // Act
      await tester.pumpWidget(
        BlocProvider<QodBloc>.value(
          value: mockQodBloc,
          child: const MaterialApp(
            home: QodView(),
          ),
        ),
      );

      // Assert
      expect(find.text('"$quoteText"'), findsOneWidget);
    });
  });
}
