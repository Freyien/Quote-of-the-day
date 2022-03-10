import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:phrase_of_the_day/domain/entities/auth_user.dart';
import 'package:phrase_of_the_day/domain/exceptions/auth_exception.dart';
import 'package:phrase_of_the_day/domain/usescases/is_device_supported_biometrics_usecase.dart';
import 'package:phrase_of_the_day/domain/usescases/login_with_biometrics_usecase.dart';
import 'package:phrase_of_the_day/domain/usescases/login_with_email_and_password_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithEmailAndPasswordUseCase _loginWithEmailAndPasswordUseCase;
  final IsDeviceSupportedBiometricsUseCase _isDeviceSupportedBiometricsUseCase;
  final LoginWithBiometricsUseCase _loginWithBiometricsUseCase;

  String _email = '';
  String _password = '';

  AuthBloc(
    this._loginWithEmailAndPasswordUseCase,
    this._isDeviceSupportedBiometricsUseCase,
    this._loginWithBiometricsUseCase,
  ) : super(InitialState()) {
    on<EmailChangedEvent>(_emailChangedEvent);
    on<PasswordChangedEvent>(_passwordChangedEvent);
    on<LoginWithEmailAndPasswordEvent>(_loginWithEmailAndPasswordEvent);
    on<CheckDeviceSupportedBiometricsEvent>(
        _checkDeviceSupportedBiometricsEvent);
    on<LoginWithBiometricsEvent>(_loginWithBiometricsEvent);
  }

  void _emailChangedEvent(EmailChangedEvent event, Emitter<AuthState> emit) {
    _email = event.email;
    emit(EmailChangedState());
  }

  void _passwordChangedEvent(
    PasswordChangedEvent event,
    Emitter<AuthState> emit,
  ) {
    _password = event.password;
    emit(PasswordChangedState());
  }

  void _loginWithEmailAndPasswordEvent(
    LoginWithEmailAndPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(LoadingState());

      final authUser =
          await _loginWithEmailAndPasswordUseCase.call(_email, _password);

      emit(SuccessState(authUser));
    } on AuthException catch (_) {
      emit(AuthFailedState());
    } catch (_) {
      emit(ServerFailedState());
    }
  }

  void _checkDeviceSupportedBiometricsEvent(
      CheckDeviceSupportedBiometricsEvent event,
      Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());
      final isSupported = await _isDeviceSupportedBiometricsUseCase.call();

      emit(BiometricsCheckedState(isSupported));
    } catch (e) {
      emit(BiometricsCheckedState(false));
    }
  }

  void _loginWithBiometricsEvent(
      LoginWithBiometricsEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingState());

      final authUser = await _loginWithBiometricsUseCase.call();

      emit(SuccessState(authUser));
    } on AuthException catch (_) {
      emit(AuthFailedState());
    } catch (_) {
      emit(ServerFailedState());
    }
  }
}
