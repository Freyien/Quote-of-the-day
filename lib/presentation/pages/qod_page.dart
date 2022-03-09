import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phrase_of_the_day/domain/entities/quote_entity.dart';
import 'package:phrase_of_the_day/presentation/bloc/qod/qod_bloc.dart';
import 'package:phrase_of_the_day/presentation/widgets/error_message.dart';
import 'package:phrase_of_the_day/presentation/widgets/loading.dart';

class QodPage extends StatelessWidget {
  const QodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QodBloc(context.read())..add(GetQodEvent()),
      child: const QodView(),
    );
  }
}

class QodView extends StatelessWidget {
  const QodView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<QodBloc, QodState>(
        builder: (context, state) {
          if (state is LoadingState || state is InitialState) {
            return const Loading();
          } else if (state is FailedState) {
            return const ErrorMessage();
          } else {
            state = state as SuccessState;
            return _QOD(quote: state.qod);
          }
        },
      ),
    );
  }
}

class _QOD extends StatelessWidget {
  const _QOD({
    Key? key,
    required this.quote,
  }) : super(key: key);

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: const Key('Qod'),
      children: [
        _BackgroundImage(backgroundUrlImage: quote.background),
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black38,
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: _Phrase('"${quote.quote}"'),
              ),
              _Author(quote.author),
            ],
          ),
        )
      ],
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({Key? key, this.backgroundUrlImage}) : super(key: key);

  final String? backgroundUrlImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: backgroundUrlImage != null
            ? CachedNetworkImage(
                key: const Key('backgroundUrlImage'),
                imageUrl: backgroundUrlImage!,
                fit: BoxFit.cover,
                placeholder: (_, __) => const Loading(),
                errorWidget: (_, __, ___) => const _BackgroundImageFromAsset(),
              )
            : const _BackgroundImageFromAsset());
  }
}

class _BackgroundImageFromAsset extends StatelessWidget {
  const _BackgroundImageFromAsset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/background.jpg',
      key: const Key('backgroundLocalImage'),
      fit: BoxFit.cover,
    );
  }
}

class _Phrase extends StatelessWidget {
  const _Phrase(
    this.phrase, {
    Key? key,
  }) : super(key: key);

  final String phrase;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        phrase,
        style: Theme.of(context).textTheme.headline5!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
      ),
    );
  }
}

class _Author extends StatelessWidget {
  const _Author(
    this.author, {
    Key? key,
  }) : super(key: key);

  final String author;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        author,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
              fontStyle: FontStyle.italic,
            ),
      ),
    );
  }
}
