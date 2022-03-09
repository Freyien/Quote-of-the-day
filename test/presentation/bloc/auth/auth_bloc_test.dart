import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:phrase_of_the_day/domain/entities/auth_user.dart';
import 'package:phrase_of_the_day/domain/exceptions/auth_exception.dart';
import 'package:phrase_of_the_day/domain/usescases/is_device_supported_biometrics_usecase.dart';
import 'package:phrase_of_the_day/domain/usescases/login_with_biometrics_usecase.dart';
import 'package:phrase_of_the_day/domain/usescases/login_with_email_and_password_usecase.dart';
import 'package:phrase_of_the_day/presentation/bloc/auth/auth_bloc.dart';

class MockAuthUser extends Mock implements AuthUser {}

class MockLoginWithEmailAndPasswordUseCase extends Mock
    implements LoginWithEmailAndPasswordUseCase {}

class MockIsDeviceSupportedBiometricsUseCase extends Mock
    implements IsDeviceSupportedBiometricsUseCase {}

class MockLoginWithBiometricsUseCase extends Mock
    implements LoginWithBiometricsUseCase {}

void main() {
  late MockLoginWithEmailAndPasswordUseCase
      mockLoginWithEmailAndPasswordUseCase;
  late MockIsDeviceSupportedBiometricsUseCase
      mockIsDeviceSupportedBiometricsUseCase;
  late MockLoginWithBiometricsUseCase mockLoginWithBiometricsUseCase;

  setUp(() {
    mockLoginWithEmailAndPasswordUseCase =
        MockLoginWithEmailAndPasswordUseCase();
    mockIsDeviceSupportedBiometricsUseCase =
        MockIsDeviceSupportedBiometricsUseCase();
    mockLoginWithBiometricsUseCase = MockLoginWithBiometricsUseCase();
  });

  group('LoginWithEmailAndPasswordEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [LoadingState, SuccessState] when LoginWithEmailAndPasswordEvent is added.',
      setUp: () {
        when(() => mockLoginWithEmailAndPasswordUseCase.call(any(), any()))
            .thenAnswer((_) async => MockAuthUser());
      },
      build: () => AuthBloc(
        mockLoginWithEmailAndPasswordUseCase,
        mockIsDeviceSupportedBiometricsUseCase,
        mockLoginWithBiometricsUseCase,
      ),
      act: (bloc) => bloc.add(LoginWithEmailAndPasswordEvent()),
      expect: () => [
        isA<LoadingState>(),
        isA<SuccessState>(),
      ],
      verify: (bloc) {
        verify(() => mockLoginWithEmailAndPasswordUseCase.call(any(), any()));
        expect(bloc.state, isA<SuccessState>());
        expect((bloc.state as SuccessState).authUser, isNotNull);
        expect((bloc.state as SuccessState).authUser, isA<AuthUser>());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [LoadingState, AuthFailedState] when LoginWithEmailAndPasswordEvent is added.',
      setUp: () {
        when(() => mockLoginWithEmailAndPasswordUseCase.call(any(), any()))
            .thenThrow(const AuthException());
      },
      build: () => AuthBloc(
        mockLoginWithEmailAndPasswordUseCase,
        mockIsDeviceSupportedBiometricsUseCase,
        mockLoginWithBiometricsUseCase,
      ),
      act: (bloc) => bloc.add(LoginWithEmailAndPasswordEvent()),
      expect: () => [
        isA<LoadingState>(),
        isA<AuthFailedState>(),
      ],
      verify: (bloc) {
        verify(() => mockLoginWithEmailAndPasswordUseCase.call(any(), any()));
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [LoadingState, Exception] when LoginWithEmailAndPasswordEvent is added.',
      setUp: () {
        when(() => mockLoginWithEmailAndPasswordUseCase.call(any(), any()))
            .thenThrow(Exception());
      },
      build: () => AuthBloc(
        mockLoginWithEmailAndPasswordUseCase,
        mockIsDeviceSupportedBiometricsUseCase,
        mockLoginWithBiometricsUseCase,
      ),
      act: (bloc) => bloc.add(LoginWithEmailAndPasswordEvent()),
      expect: () => [
        isA<LoadingState>(),
        isA<ServerFailedState>(),
      ],
      verify: (_) {
        verify(() => mockLoginWithEmailAndPasswordUseCase.call(any(), any()));
      },
    );
  });

  group('CheckDeviceSupportedBiometricsEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [LoadingState, BiometricsCheckedState(true)] when CheckDeviceSupportedBiometricsEvent is added.',
      setUp: () {
        when(() => mockIsDeviceSupportedBiometricsUseCase.call())
            .thenAnswer((_) async => true);
      },
      build: () => AuthBloc(
        mockLoginWithEmailAndPasswordUseCase,
        mockIsDeviceSupportedBiometricsUseCase,
        mockLoginWithBiometricsUseCase,
      ),
      act: (bloc) => bloc.add(CheckDeviceSupportedBiometricsEvent()),
      expect: () => [
        isA<LoadingState>(),
        isA<BiometricsCheckedState>(),
      ],
      verify: (bloc) {
        verify(() => mockIsDeviceSupportedBiometricsUseCase.call());
        expect(bloc.state, isA<BiometricsCheckedState>());
        expect(
            (bloc.state as BiometricsCheckedState).isBiometricsSupported, true);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [LoadingState, BiometricsCheckedState(false)] when CheckDeviceSupportedBiometricsEvent is added.',
      setUp: () {
        when(() => mockIsDeviceSupportedBiometricsUseCase.call())
            .thenAnswer((_) async => false);
      },
      build: () => AuthBloc(
        mockLoginWithEmailAndPasswordUseCase,
        mockIsDeviceSupportedBiometricsUseCase,
        mockLoginWithBiometricsUseCase,
      ),
      act: (bloc) => bloc.add(CheckDeviceSupportedBiometricsEvent()),
      expect: () => [
        isA<LoadingState>(),
        isA<BiometricsCheckedState>(),
      ],
      verify: (bloc) {
        verify(() => mockIsDeviceSupportedBiometricsUseCase.call());
        expect(bloc.state, isA<BiometricsCheckedState>());
        expect((bloc.state as BiometricsCheckedState).isBiometricsSupported,
            false);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [LoadingState, BiometricsCheckedState(false)] when CheckDeviceSupportedBiometricsEvent throw Exception.',
      setUp: () {
        when(() => mockIsDeviceSupportedBiometricsUseCase.call())
            .thenThrow(Exception());
      },
      build: () => AuthBloc(
        mockLoginWithEmailAndPasswordUseCase,
        mockIsDeviceSupportedBiometricsUseCase,
        mockLoginWithBiometricsUseCase,
      ),
      act: (bloc) => bloc.add(CheckDeviceSupportedBiometricsEvent()),
      expect: () => [
        isA<LoadingState>(),
        isA<BiometricsCheckedState>(),
      ],
      verify: (bloc) {
        verify(() => mockIsDeviceSupportedBiometricsUseCase.call());
        expect(bloc.state, isA<BiometricsCheckedState>());
        expect((bloc.state as BiometricsCheckedState).isBiometricsSupported,
            false);
      },
    );
  });

  group('LoginWithBiometricsEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [LoadingState, SuccessState] when LoginWithBiometricsEvent is added.',
      setUp: () {
        when(() => mockLoginWithBiometricsUseCase.call())
            .thenAnswer((_) async => MockAuthUser());
      },
      build: () => AuthBloc(
        mockLoginWithEmailAndPasswordUseCase,
        mockIsDeviceSupportedBiometricsUseCase,
        mockLoginWithBiometricsUseCase,
      ),
      act: (bloc) => bloc.add(LoginWithBiometricsEvent()),
      expect: () => [
        isA<LoadingState>(),
        isA<SuccessState>(),
      ],
      verify: (bloc) {
        verify(() => mockLoginWithBiometricsUseCase.call());
        expect(bloc.state, isA<SuccessState>());
        expect((bloc.state as SuccessState).authUser, isNotNull);
        expect((bloc.state as SuccessState).authUser, isA<AuthUser>());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [LoadingState, AuthFailedState] when LoginWithBiometricsEvent is added.',
      setUp: () {
        when(() => mockLoginWithBiometricsUseCase.call())
            .thenThrow(const AuthException());
      },
      build: () => AuthBloc(
        mockLoginWithEmailAndPasswordUseCase,
        mockIsDeviceSupportedBiometricsUseCase,
        mockLoginWithBiometricsUseCase,
      ),
      act: (bloc) => bloc.add(LoginWithBiometricsEvent()),
      expect: () => [
        isA<LoadingState>(),
        isA<AuthFailedState>(),
      ],
      verify: (bloc) {
        verify(() => mockLoginWithBiometricsUseCase.call());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [LoadingState, ServerFailedState] when LoginWithBiometricsEvent is added.',
      setUp: () {
        when(() => mockLoginWithBiometricsUseCase.call())
            .thenThrow(Exception());
      },
      build: () => AuthBloc(
        mockLoginWithEmailAndPasswordUseCase,
        mockIsDeviceSupportedBiometricsUseCase,
        mockLoginWithBiometricsUseCase,
      ),
      act: (bloc) => bloc.add(LoginWithBiometricsEvent()),
      expect: () => [
        isA<LoadingState>(),
        isA<ServerFailedState>(),
      ],
      verify: (bloc) {
        verify(() => mockLoginWithBiometricsUseCase.call());
      },
    );
  });
}
