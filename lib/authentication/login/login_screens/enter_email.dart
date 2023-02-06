
import 'package:flutter/material.dart';

class EnterEmail extends StatelessWidget {
  const EnterEmail({
    Key? key,
    required TextEditingController email,
  }) : _email = email, super(key: key);

  final TextEditingController _email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: TextField(
            controller: _email,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email_outlined),
              hintText: 'Nhập email của bạn',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22.0)),
              labelText: "Tên Đăng Nhập",
              labelStyle: const TextStyle(
                color: Color.fromARGB(255, 29, 29, 29),
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

