import 'package:phrase_of_the_day/domain/entities/auth_user.dart';
import 'package:phrase_of_the_day/domain/repositories/auth_repository.dart';

class LoginWithBiometricsUseCase {
  final AuthRepository _authRepository;

  LoginWithBiometricsUseCase(this._authRepository);

  Future<AuthUser> call() async {
    return _authRepository.loginWithBiometrics();
  }
}
