import 'package:flutter/material.dart';

class DoctorImageLogin extends StatelessWidget {
  const DoctorImageLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 20),
      child: Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(255, 219, 228, 226),
        ),
        child: FittedBox(child: Image.asset('assets/images/icon_doctor.png')),
      ),
    );
  }
}
