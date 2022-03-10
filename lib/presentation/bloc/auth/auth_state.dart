part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class InitialState extends AuthState {}

class LoadingState extends AuthState {}

class BiometricsCheckedState extends AuthState {
  final bool isBiometricsSupported;

  BiometricsCheckedState(this.isBiometricsSupported);
}

class SuccessState extends AuthState {
  final AuthUser authUser;

  SuccessState(this.authUser);
}

class AuthFailedState extends AuthState {}

class ServerFailedState extends AuthState {}

class EmailChangedState extends AuthState {}

class PasswordChangedState extends AuthState {}
