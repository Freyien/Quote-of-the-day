import 'package:flutter_test/flutter_test.dart';
import 'package:phrase_of_the_day/data/remote/auth_remote_impl.dart';
import 'package:phrase_of_the_day/domain/entities/auth_user.dart';
import 'package:phrase_of_the_day/domain/exceptions/auth_exception.dart';
import 'package:phrase_of_the_day/domain/repositories/auth_repository.dart';

void main() {
  late AuthRepository authRepository;

  setUp(() {
    authRepository = AuthRemoteImpl();
  });

  group('loginWithEmailAndPassword', () {
    test('Should return AuthUser with correct credentials', () async {
      // Arrange
      // Act
      final result = await authRepository.loginWithEmailAndPassword(
        'freyien@fondeadora.com',
        '123456',
      );

      // Assert
      expect(result, isNotNull);
      expect(result, isA<AuthUser>());
    });

    test('Should throw AuthException when email is incorrect', () async {
      // Arrange
      // Act

      // Assert
      expect(
        () async => await authRepository.loginWithEmailAndPassword(
          'fernando@fondeadora.com',
          '123456',
        ),
        throwsA(isA<AuthException>()),
      );
    });

    test('Should throw AuthException when password is incorrect', () async {
      // Arrange
      // Act

      // Assert
      expect(
        () async => await authRepository.loginWithEmailAndPassword(
          'freyien@fondeadora.com',
          '123457',
        ),
        throwsA(isA<AuthException>()),
      );
    });
  });

  group('isDeviceSupportedBiometrics', () {
    test('Should return true', () async {
      // Arrange

      // Act
      final result = await authRepository.isDeviceSupportedBiometrics();

      // Assert
      expect(result, isNotNull);
      expect(result, true);
    });
  });

  group('loginWithBiometrics', () {
    test('Should return AuthUser', () async {
      // Arrange

      // Act
      final result = await authRepository.loginWithBiometrics();

      // Assert
      expect(result, isNotNull);
      expect(result, isA<AuthUser>());
    });
  });
}
