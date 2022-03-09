import 'package:phrase_of_the_day/domain/entities/auth_user.dart';
import 'package:phrase_of_the_day/domain/repositories/auth_repository.dart';

class LoginWithEmailAndPasswordUseCase {
  final AuthRepository _authRepository;

  LoginWithEmailAndPasswordUseCase(this._authRepository);

  Future<AuthUser> call(String email, String password) async =>
      await _authRepository.loginWithEmailAndPassword(email, password);
}
