import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phrase_of_the_day/dependencies/di.dart';
import 'package:phrase_of_the_day/presentation/pages/login_page.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:phrase_of_the_day/presentation/pages/qod_page.dart';

void main() => runApp(const _DI());

class _DI extends StatelessWidget {
  const _DI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildDependencies(),
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote of the day',
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/QOD': (_) => const QodPage()
      },
    );
  }
}
