import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:phrase_of_the_day/domain/entities/auth_user.dart';
import 'package:phrase_of_the_day/domain/repositories/auth_repository.dart';
import 'package:phrase_of_the_day/domain/usescases/login_with_biometrics_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthUser extends Mock implements AuthUser {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late LoginWithBiometricsUseCase loginWithBiometricsUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginWithBiometricsUseCase = LoginWithBiometricsUseCase(mockAuthRepository);
  });

  group('call', () {
    test('Should return AuthUser', () async {
      // Arrange
      when(() => mockAuthRepository.loginWithBiometrics())
          .thenAnswer((_) async => MockAuthUser());

      // Act
      final result = await loginWithBiometricsUseCase.call();

      // Assert
      expect(result, isNotNull);
      expect(result, isA<AuthUser>());
      verify(() => mockAuthRepository.loginWithBiometrics());
    });

    test('Should throw', () async {
      // Arrange
      when(() => mockAuthRepository.loginWithBiometrics())
          .thenThrow(Exception());

      // Act
      // Assert
      expect(
        () async => await loginWithBiometricsUseCase.call(),
        throwsA(isA<Exception>()),
      );
      verify(() => mockAuthRepository.loginWithBiometrics());
    });
  });
}
