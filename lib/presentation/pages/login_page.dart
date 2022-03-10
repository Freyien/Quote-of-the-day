import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:phrase_of_the_day/presentation/bloc/auth/auth_bloc.dart';
import 'package:phrase_of_the_day/presentation/utils/toasts.dart';
import 'package:phrase_of_the_day/presentation/utils/validators.dart';
import 'package:phrase_of_the_day/presentation/widgets/input_text.dart';
import 'package:phrase_of_the_day/presentation/widgets/primary_button.dart';
import 'package:phrase_of_the_day/presentation/widgets/secondary_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        context.read(),
        context.read(),
        context.read(),
      )..add(CheckDeviceSupportedBiometricsEvent()),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: const [
                // Flutter Logo
                SizedBox(height: 48),
                FlutterLogo(size: 90),
                SizedBox(height: 48),

                // Form
                _EmailAndPasswordForm(),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _EmailAndPasswordForm extends StatelessWidget {
  const _EmailAndPasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email
          InputText(
            key: const Key('emailInput'),
            hintText: 'Correo electrónico',
            prefixIcon: const Icon(
              Icons.email_outlined,
              size: 30,
              color: Colors.grey,
            ),
            textInputAction: TextInputAction.next,
            onChanged: (email) =>
                context.read<AuthBloc>().add(EmailChangedEvent(email)),
            validator: Validators.validateEmail,
          ),
          const SizedBox(height: 18),

          // Password
          InputText(
            key: const Key('passwordInput'),
            hintText: 'Contraseña',
            obscureText: true,
            prefixIcon: const Icon(
              Icons.lock_outline,
              size: 30,
              color: Colors.grey,
            ),
            onChanged: (password) =>
                context.read<AuthBloc>().add(PasswordChangedEvent(password)),
            validator: Validators.validatePassword,
          ),
          const SizedBox(height: 32),

          // Buttons
          _LoginWithEmailButton(formKey: _formKey),

          // Login with biometrics button
          const _BiometricsOptionButton()
        ],
      ),
    );
  }
}

class _LoginWithEmailButton extends StatelessWidget {
  const _LoginWithEmailButton({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailedState) {
          Toast().showErrorToast('Datos ingresados son incorrectos');
        } else if (state is ServerFailedState) {
          Toast().showErrorToast('Ha ocurrido un error inesperado :p');
        } else if (state is SuccessState) {
          Navigator.pushReplacementNamed(context, '/QOD');
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return const CircularProgressIndicator();
        }

        return Column(
          children: [
            // Login with email and password button
            PrimaryButton(
              key: const Key('loginButton'),
              onPressed: () {
                if (!formKey.currentState!.validate()) return;

                context.read<AuthBloc>().add(LoginWithEmailAndPasswordEvent());
              },
              text: 'Iniciar sesión',
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}

class _BiometricsOptionButton extends StatelessWidget {
  const _BiometricsOptionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (_, state) => state is BiometricsCheckedState,
      builder: (context, state) {
        if (state is BiometricsCheckedState) {
          if (!state.isBiometricsSupported) return const SizedBox.shrink();

          return Column(
            key: const Key('biometricsOptions'),
            children: [
              // Or text
              const Text(
                'O',
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.75,
                ),
              ),
              const SizedBox(height: 24),

              // BiometricsButton
              SecondaryButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LoginWithBiometricsEvent());
                },
                text: 'Inicia sesión con tus datos biométricos',
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
