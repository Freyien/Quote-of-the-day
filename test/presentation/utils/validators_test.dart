import 'package:flutter_test/flutter_test.dart';
import 'package:phrase_of_the_day/presentation/utils/validators.dart';

void main() {
  group('validateEmail', () {
    test('Should return null', () {
      // Arrange
      // Act
      final result = Validators.validateEmail('freyien@fondeador.com');

      // Assert
      expect(result, isNull);
    });

    test('Should return String with error', () {
      // Arrange
      // Act
      final result = Validators.validateEmail('freyien');

      // Assert
      expect(result, isA<String>());
      expect(result, isNotNull);
      expect(result, 'Email inválido');
    });
  });

  group('validatePassword', () {
    test('Should return null', () {
      // Arrange
      // Act
      final result = Validators.validatePassword('123456');

      // Assert
      expect(result, isNull);
    });

    test('Should return String with error', () {
      // Arrange
      // Act
      final result = Validators.validatePassword('12345');

      // Assert
      expect(result, isA<String>());
      expect(result, isNotNull);
      expect(result, 'Contraseña muy corta');
    });
  });
}
