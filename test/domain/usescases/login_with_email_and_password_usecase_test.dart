import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:phrase_of_the_day/domain/entities/auth_user.dart';
import 'package:phrase_of_the_day/domain/exceptions/auth_exception.dart';
import 'package:phrase_of_the_day/domain/repositories/auth_repository.dart';
import 'package:phrase_of_the_day/domain/usescases/login_with_email_and_password_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthUser extends Mock implements AuthUser {}

void main() {
  const email = 'freyien@fondeadora.com';
  const password = '123456';

  late MockAuthRepository mockAuthRepository;
  late LoginWithEmailAndPasswordUseCase loginWithEmailAndPasswordUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginWithEmailAndPasswordUseCase =
        LoginWithEmailAndPasswordUseCase(mockAuthRepository);
  });

  group('call', () {
    test('Should return AuthUser', () async {
      // Arrange
      when(() => mockAuthRepository.loginWithEmailAndPassword(email, password))
          .thenAnswer((_) async => MockAuthUser());

      // Act
      final result =
          await loginWithEmailAndPasswordUseCase.call(email, password);

      // Assert
      expect(result, isNotNull);
      expect(result, isA<AuthUser>());
      verify(
          () => mockAuthRepository.loginWithEmailAndPassword(email, password));
    });

    test('Should throw AuthException', () async {
      // Arrange
      when(() => mockAuthRepository.loginWithEmailAndPassword(email, password))
          .thenThrow(const AuthException());

      // Act
      // Assert
      expect(
        () async =>
            await loginWithEmailAndPasswordUseCase.call(email, password),
        throwsA(isA<AuthException>()),
      );
      verify(
          () => mockAuthRepository.loginWithEmailAndPassword(email, password));
    });

    test('Should throw Exception', () async {
      // Arrange
      when(() => mockAuthRepository.loginWithEmailAndPassword(email, password))
          .thenThrow(Exception());

      // Act
      // Assert
      expect(
        () async =>
            await loginWithEmailAndPasswordUseCase.call(email, password),
        throwsA(isA<Exception>()),
      );
      verify(
          () => mockAuthRepository.loginWithEmailAndPassword(email, password));
    });
  });
}
