import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key('errorMessage'),
      child: Text('Ha ocurrido un error'),
    );
  }
}
