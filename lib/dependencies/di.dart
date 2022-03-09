import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:phrase_of_the_day/data/local/auth_local_impl.dart';
import 'package:phrase_of_the_day/data/remote/auth_remote_impl.dart';
import 'package:phrase_of_the_day/data/remote/quote_remote_impl.dart';
import 'package:phrase_of_the_day/domain/repositories/quote_repository.dart';
import 'package:phrase_of_the_day/domain/usescases/get_qod_usecase.dart';
import 'package:phrase_of_the_day/domain/usescases/is_device_supported_biometrics_usecase.dart';
import 'package:phrase_of_the_day/domain/usescases/login_with_biometrics_usecase.dart';
import 'package:phrase_of_the_day/domain/usescases/login_with_email_and_password_usecase.dart';

List<RepositoryProvider> buildDependencies() {
  final _client = Dio();
  _client.options = BaseOptions(
    baseUrl: 'https://quotes.rest',
  );

  return [
    RepositoryProvider<LocalAuthentication>(
      create: (_) => LocalAuthentication(),
    ),
    RepositoryProvider<Dio>(
      create: (_) => _client,
    ),

    // Data
    RepositoryProvider<AuthRemoteImpl>(
      create: (_) => AuthRemoteImpl(),
    ),
    RepositoryProvider<AuthLocalImpl>(
      create: (context) => AuthLocalImpl(context.read()),
    ),
    RepositoryProvider<QuoteRepository>(
      create: (context) => QuoteRemoteImpl(context.read()),
    ),

    // Use cases
    RepositoryProvider<LoginWithEmailAndPasswordUseCase>(
      create: (context) =>
          LoginWithEmailAndPasswordUseCase(context.read<AuthRemoteImpl>()),
    ),
    RepositoryProvider<IsDeviceSupportedBiometricsUseCase>(
      create: (context) =>
          IsDeviceSupportedBiometricsUseCase(context.read<AuthLocalImpl>()),
    ),
    RepositoryProvider<LoginWithBiometricsUseCase>(
      create: (context) =>
          LoginWithBiometricsUseCase(context.read<AuthLocalImpl>()),
    ),
    RepositoryProvider<GetQodUsecase>(
      create: (context) => GetQodUsecase(context.read()),
    ),
  ];
}
