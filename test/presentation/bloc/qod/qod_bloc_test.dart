import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:phrase_of_the_day/domain/entities/quote_entity.dart';
import 'package:phrase_of_the_day/domain/usescases/get_qod_usecase.dart';
import 'package:phrase_of_the_day/presentation/bloc/qod/qod_bloc.dart';

class MockGetQodUsecase extends Mock implements GetQodUsecase {}

class MockQuote extends Mock implements Quote {}

void main() {
  late MockGetQodUsecase mockGetQodUsecase;

  setUp(() {
    mockGetQodUsecase = MockGetQodUsecase();
  });

  group('GetQodEvent', () {
    blocTest<QodBloc, QodState>(
      'emits [SuccessState] when GetQodEvent is added.',
      setUp: () {
        when(() => mockGetQodUsecase.call())
            .thenAnswer((_) async => MockQuote());
      },
      build: () => QodBloc(mockGetQodUsecase),
      act: (bloc) => bloc.add(GetQodEvent()),
      expect: () => [
        isA<LoadingState>(),
        isA<SuccessState>(),
      ],
      verify: (bloc) {
        verify(() => mockGetQodUsecase.call());
        expect(bloc.state, isA<SuccessState>());
        expect((bloc.state as SuccessState).qod, isNotNull);
        expect((bloc.state as SuccessState).qod, isA<Quote>());
      },
    );
    blocTest<QodBloc, QodState>(
      'emits [FailedState] when GetQodEvent is added.',
      setUp: () {
        when(() => mockGetQodUsecase.call()).thenThrow(Exception());
      },
      build: () => QodBloc(mockGetQodUsecase),
      act: (bloc) => bloc.add(GetQodEvent()),
      expect: () => [
        isA<LoadingState>(),
        isA<FailedState>(),
      ],
      verify: (bloc) {
        verify(() => mockGetQodUsecase.call());
      },
    );
  });
}
