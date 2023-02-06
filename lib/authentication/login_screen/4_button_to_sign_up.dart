import 'package:demo_app2/authentication/sign_up_screen/1_sign_up_screen.dart';
import 'package:flutter/material.dart';

import '../login/signup.dart';

class ButtonToSignUp extends StatelessWidget {
  const ButtonToSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: const <Widget>[
          Icon(Icons.app_registration_outlined),
          Text(
            "Đăng ký ",
            style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 28, 27, 27),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()));
      },
    );
  }
}
