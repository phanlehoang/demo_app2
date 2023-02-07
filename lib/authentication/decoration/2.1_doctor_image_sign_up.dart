import 'package:flutter/material.dart';

class DoctorImageSignUp extends StatelessWidget {
  const DoctorImageSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Container(
        width: 80,
        height: 80,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
        child: Image.asset('assets/images/icon_doctor.png'),
      ),
    );
  }
}
