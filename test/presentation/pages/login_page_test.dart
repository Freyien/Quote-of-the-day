import 'package:bloc_test/bloc_test.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:phrase_of_the_day/domain/entities/auth_user.dart';
import 'package:phrase_of_the_day/presentation/bloc/auth/auth_bloc.dart';
import 'package:phrase_of_the_day/presentation/pages/login_page.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockAuthUser extends Mock implements AuthUser {}

void main() {
  late MockAuthBloc mockAuthBloc;
  late MockNavigator mockNavigator;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    mockNavigator = MockNavigator();
  });

  group('_BiometricsOptionButton', () {
    testWidgets('Should show login with biometrics button', (tester) async {
      // Arrange
      when(() => mockAuthBloc.state).thenReturn(BiometricsCheckedState(true));

      // Act
      await tester.pumpWidget(
        BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: const MaterialApp(
            home: LoginView(),
          ),
        ),
      );

      // Assert
      expect(find.byKey(const Key('biometricsOptions')), findsOneWidget);
    });

    testWidgets('Should hide login with biometrics button', (tester) async {
      // Arrange
      when(() => mockAuthBloc.state).thenReturn(BiometricsCheckedState(false));

      // Act
      await tester.pumpWidget(
        BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: const MaterialApp(
            home: LoginView(),
          ),
        ),
      );

      // Assert
      expect(find.byKey(const Key('biometricsOptions')), findsNothing);
    });
  });

  group('EmailInput', () {
    const emailError = 'Email inválido';

    testWidgets('Should show error with bad format', (tester) async {
      // Arrange
      const email = 'freyien';
      when(() => mockAuthBloc.state).thenReturn(InitialState());

      // Act
      await tester.pumpWidget(
        BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: const MaterialApp(
            home: LoginView(),
          ),
        ),
      );

      await tester.enterText(find.byKey(const Key('emailInput')), email);
      await tester.pump();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pump();

      // Assert
      expect(find.text(emailError), findsOneWidget);
    });

    testWidgets('Should hide error', (tester) async {
      // Arrange
      const email = 'freyien@fondeadora.com';
      when(() => mockAuthBloc.state).thenReturn(InitialState());

      // Act
      await tester.pumpWidget(
        BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: const MaterialApp(
            home: LoginView(),
          ),
        ),
      );

      await tester.enterText(find.byKey(const Key('emailInput')), email);
      await tester.pump();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pump();

      // Assert
      expect(find.text(emailError), findsNothing);
    });
  });

  group('PasswordInput', () {
    const passwordError = 'Contraseña muy corta';

    testWidgets('Should show error with bad format', (tester) async {
      // Arrange
      const password = '12345';
      when(() => mockAuthBloc.state).thenReturn(InitialState());

      // Act
      await tester.pumpWidget(
        BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: const MaterialApp(
            home: LoginView(),
          ),
        ),
      );

      await tester.enterText(find.byKey(const Key('passwordInput')), password);
      await tester.pump();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pump();

      // Assert
      expect(find.text(passwordError), findsOneWidget);
    });

    testWidgets('Should hide error', (tester) async {
      // Arrange
      const password = '123456';
      when(() => mockAuthBloc.state).thenReturn(InitialState());

      // Act
      await tester.pumpWidget(
        BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: const MaterialApp(
            home: LoginView(),
          ),
        ),
      );

      await tester.enterText(find.byKey(const Key('passwordInput')), password);
      await tester.pump();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pump();

      // Assert
      expect(find.text(passwordError), findsNothing);
    });
  });

  group('login', () {
    setUpAll(() {
      registerFallbackValue(LoginWithEmailAndPasswordEvent());
      registerFallbackValue(LoginWithBiometricsEvent());
    });
    testWidgets('Should navigate to another page when SuccessState is emitted',
        (tester) async {
      // Arrange
      when(() => mockNavigator.pushReplacementNamed(any()))
          .thenAnswer((_) async => null);

      whenListen(
        mockAuthBloc,
        Stream.fromIterable([
          LoadingState(),
          SuccessState(MockAuthUser()),
        ]),
        initialState: InitialState(),
      );

      // Act
      await tester.pumpWidget(
        BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: MaterialApp(
            home: MockNavigatorProvider(
              navigator: mockNavigator,
              child: const LoginView(),
            ),
          ),
        ),
      );

      // Assert
      verify(() => mockNavigator.pushReplacementNamed(any()));
    });

    testWidgets('Should show toast when AuthFailedState is emitted',
        (tester) async {
      // Arrange
      whenListen(
        mockAuthBloc,
        Stream.fromIterable([
          LoadingState(),
          AuthFailedState(),
        ]),
        initialState: InitialState(),
      );

      // Act
      await tester.pumpWidget(
        BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: MaterialApp(
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            home: MockNavigatorProvider(
              navigator: mockNavigator,
              child: const LoginView(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.byKey(const Key('errorToast')), findsOneWidget);
      expect(find.text('Datos ingresados son incorrectos'), findsOneWidget);
    });

    testWidgets('Should show toast when ServerFailedState is emitted',
        (tester) async {
      // Arrange
      whenListen(
        mockAuthBloc,
        Stream.fromIterable([
          LoadingState(),
          ServerFailedState(),
        ]),
        initialState: InitialState(),
      );

      // Act
      await tester.pumpWidget(
        BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: MaterialApp(
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            home: MockNavigatorProvider(
              navigator: mockNavigator,
              child: const LoginView(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.byKey(const Key('errorToast')), findsOneWidget);
      expect(find.text('Ha ocurrido un error inesperado :p'), findsOneWidget);
    });

    testWidgets(
        'Should emit LoginWithEmailAndPasswordEvent when login button is pressed',
        (tester) async {
      // Arrange
      const email = 'freyien@fondeadora.com';
      const password = '123456';

      when(() => mockAuthBloc.state).thenReturn(InitialState());

      // Act
      await tester.pumpWidget(
        BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: const MaterialApp(home: LoginView()),
        ),
      );

      await tester.enterText(find.byKey(const Key('emailInput')), email);
      await tester.enterText(find.byKey(const Key('passwordInput')), password);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();

      verify(() => mockAuthBloc.add(any<LoginWithEmailAndPasswordEvent>()));
    });

    testWidgets(
        'Should emit LoginWithBiometricsEvent when login with biometrics button is pressed',
        (tester) async {
      // Arrange
      when(() => mockAuthBloc.state).thenReturn(BiometricsCheckedState(true));

      // Act
      await tester.pumpWidget(
        BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: const MaterialApp(home: LoginView()),
        ),
      );

      await tester.tap(find.byKey(const Key('loginWithBiometricsButton')));
      await tester.pumpAndSettle();

      // Assert
      verify(() => mockAuthBloc.add(any<LoginWithBiometricsEvent>()));
    });
  });
}
