import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:phrase_of_the_day/data/local/auth_local_impl.dart';
import 'package:phrase_of_the_day/domain/entities/auth_user.dart';
import 'package:phrase_of_the_day/domain/exceptions/auth_exception.dart';
import 'package:phrase_of_the_day/domain/repositories/auth_repository.dart';

class MockLocalAuthentication extends Mock implements LocalAuthentication {}

class MockAndroidAuthMessages extends Mock implements AndroidAuthMessages {}

void main() {
  late MockLocalAuthentication mockLocalAuthentication;
  late AuthRepository authRepository;

  setUp(() {
    mockLocalAuthentication = MockLocalAuthentication();
    authRepository = AuthLocalImpl(mockLocalAuthentication);
  });

  group('isDeviceSupportedBiometrics', () {
    test('Should return true', () async {
      // Arrange
      when(() => mockLocalAuthentication.isDeviceSupported())
          .thenAnswer((_) async => true);

      // Act
      final result = await authRepository.isDeviceSupportedBiometrics();

      // Assert
      expect(result, true);
      verify(() => mockLocalAuthentication.isDeviceSupported());
    });

    test('Should return false', () async {
      // Arrange
      when(() => mockLocalAuthentication.isDeviceSupported())
          .thenAnswer((_) async => false);

      // Act
      final result = await authRepository.isDeviceSupportedBiometrics();

      // Assert
      expect(result, false);
      verify(() => mockLocalAuthentication.isDeviceSupported());
    });
  });

  group('loginWithBiometrics', () {
    setUpAll(() {
      registerFallbackValue(MockAndroidAuthMessages());
    });

    test('Should return AuthUser', () async {
      // Arrange
      when(
        () => mockLocalAuthentication.authenticate(
          localizedReason: 'Ingresa tus datos para avanzar',
          androidAuthStrings: any(named: 'androidAuthStrings'),
        ),
      ).thenAnswer((async) async => true);

      // Act
      final result = await authRepository.loginWithBiometrics();

      // Assert
      expect(result, isNotNull);
      expect(result, isA<AuthUser>());
      verify(
        () => mockLocalAuthentication.authenticate(
          localizedReason: 'Ingresa tus datos para avanzar',
          androidAuthStrings: any(named: 'androidAuthStrings'),
        ),
      );
    });

    test('Should throws AuthException', () async {
      // Arrange
      when(
        () => mockLocalAuthentication.authenticate(
          localizedReason: 'Ingresa tus datos para avanzar',
          androidAuthStrings: any(named: 'androidAuthStrings'),
        ),
      ).thenAnswer((async) async => false);

      // Act

      // Assert
      expect(
        () async => await authRepository.loginWithBiometrics(),
        throwsA(isA<AuthException>()),
      );
      verify(
        () => mockLocalAuthentication.authenticate(
          localizedReason: 'Ingresa tus datos para avanzar',
          androidAuthStrings: any(named: 'androidAuthStrings'),
        ),
      );
    });
  });
}
