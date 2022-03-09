import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:phrase_of_the_day/domain/entities/auth_user.dart';
import 'package:phrase_of_the_day/domain/exceptions/auth_exception.dart';
import 'package:phrase_of_the_day/domain/repositories/auth_repository.dart';

class AuthLocalImpl implements AuthRepository {
  final LocalAuthentication _localAuthentication;

  AuthLocalImpl(this._localAuthentication);

  @override
  Future<bool> isDeviceSupportedBiometrics() async {
    return await _localAuthentication.isDeviceSupported();
  }

  @override
  Future<AuthUser> loginWithBiometrics() async {
    final didAuthenticate = await _localAuthentication.authenticate(
      localizedReason: 'Ingresa tus datos para avanzar',
      androidAuthStrings: const AndroidAuthMessages(
        signInTitle: 'Iniciar sesión',
        goToSettingsDescription: 'Presiona el botón para ir a configuración',
        biometricHint: 'Estás a solo un paso de alcanzar la felicidad',
        biometricNotRecognized: 'Datos biométricos no reconocidos',
        biometricRequiredTitle: 'Datos biométricos son requeridos',
        biometricSuccess: 'Datos biométricos correctos',
        cancelButton: 'Cancelar',
        deviceCredentialsRequiredTitle: 'Credenciales requeridas',
        deviceCredentialsSetupDescription: 'Configuración de credenciales',
        goToSettingsButton: 'Ir a configuración',
      ),
    );

    if (!didAuthenticate) throw const AuthException();

    return AuthUser(id: 1, username: 'Freyien');
  }

  @override
  Future<AuthUser> loginWithEmailAndPassword(String email, String password) {
    throw UnimplementedError();
  }
}
