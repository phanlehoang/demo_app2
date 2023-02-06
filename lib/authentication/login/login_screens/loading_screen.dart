import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
    required this.flag_login,
  }) : super(key: key);

  final bool flag_login;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: flag_login,
      child: FittedBox(
        child: Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.symmetric(
              vertical: 280, horizontal: 170),
          child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 255, 255, 255))),
        ),
      ),
    );
  }
}
