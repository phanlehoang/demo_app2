import 'package:flutter/material.dart';

import '../status/internet_check_widgets.dart';
import '0_nice_screen.dart';

class NiceInternetScreen extends StatelessWidget {
  final Widget child;
  const NiceInternetScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InternetCheck(
      child: NiceScreen(
        child: child,
      ),
    );
  }
}
