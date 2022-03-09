import 'package:phrase_of_the_day/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> loginWithEmailAndPassword(String email, String password);
  Future<bool> isDeviceSupportedBiometrics();
  Future<AuthUser> loginWithBiometrics();
}
