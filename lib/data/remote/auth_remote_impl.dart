import 'package:phrase_of_the_day/domain/entities/auth_user.dart';
import 'package:phrase_of_the_day/domain/exceptions/auth_exception.dart';
import 'package:phrase_of_the_day/domain/repositories/auth_repository.dart';

class AuthRemoteImpl implements AuthRepository {
  @override
  Future<AuthUser> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    if (email != 'freyien@fondeadora.com') throw const AuthException();
    if (password != '123456') throw const AuthException();

    return AuthUser(id: 1, username: 'Freyien');
  }

  @override
  Future<bool> isDeviceSupportedBiometrics() async {
    // Not implementes in local
    return true;
  }

  @override
  Future<AuthUser> loginWithBiometrics() async {
    // Not implementes in local
    return AuthUser(id: 1, username: 'Freyien');
  }
}
