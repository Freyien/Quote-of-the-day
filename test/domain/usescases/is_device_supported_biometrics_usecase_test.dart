import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:phrase_of_the_day/domain/repositories/auth_repository.dart';
import 'package:phrase_of_the_day/domain/usescases/is_device_supported_biometrics_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late IsDeviceSupportedBiometricsUseCase isDeviceSupportedBiometricsUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    isDeviceSupportedBiometricsUseCase =
        IsDeviceSupportedBiometricsUseCase(mockAuthRepository);
  });

  group('call', () {
    test('Should return true', () async {
      // Arrange
      when(() => mockAuthRepository.isDeviceSupportedBiometrics())
          .thenAnswer((_) async => true);

      // Act
      final result = await isDeviceSupportedBiometricsUseCase.call();

      // Assert
      expect(result, true);
      expect(result, isNotNull);
      expect(result, isA<bool>());
      verify(() => mockAuthRepository.isDeviceSupportedBiometrics());
    });

    test('Should return false', () async {
      // Arrange
      when(() => mockAuthRepository.isDeviceSupportedBiometrics())
          .thenAnswer((_) async => false);

      // Act
      final result = await isDeviceSupportedBiometricsUseCase.call();

      // Assert
      expect(result, false);
      expect(result, isNotNull);
      expect(result, isA<bool>());
      verify(() => mockAuthRepository.isDeviceSupportedBiometrics());
    });

    test('Should throw Exception', () async {
      // Arrange
      when(() => mockAuthRepository.isDeviceSupportedBiometrics())
          .thenThrow(Exception());

      // Act
      // Assert
      expect(
        () async => await isDeviceSupportedBiometricsUseCase.call(),
        throwsA(isA<Exception>()),
      );
      verify(() => mockAuthRepository.isDeviceSupportedBiometrics());
    });
  });
}
