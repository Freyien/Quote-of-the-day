part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class EmailChangedEvent extends AuthEvent {
  final String email;

  EmailChangedEvent(this.email);
}

class PasswordChangedEvent extends AuthEvent {
  final String password;

  PasswordChangedEvent(this.password);
}

class LoginWithEmailAndPasswordEvent extends AuthEvent {}

class CheckDeviceSupportedBiometricsEvent extends AuthEvent {}

class LoginWithBiometricsEvent extends AuthEvent {}
