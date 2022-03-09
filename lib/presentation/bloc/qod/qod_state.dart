part of 'qod_bloc.dart';

@immutable
abstract class QodState {}

class InitialState extends QodState {}

class LoadingState extends QodState {}

class SuccessState extends QodState {
  final Quote qod;

  SuccessState(this.qod);
}

class FailedState extends QodState {}
