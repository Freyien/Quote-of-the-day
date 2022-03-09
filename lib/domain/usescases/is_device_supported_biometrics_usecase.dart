import 'package:phrase_of_the_day/domain/repositories/auth_repository.dart';

class IsDeviceSupportedBiometricsUseCase {
  final AuthRepository _authRepository;

  IsDeviceSupportedBiometricsUseCase(this._authRepository);

  Future<bool> call() async {
    return _authRepository.isDeviceSupportedBiometrics();
  }
}
