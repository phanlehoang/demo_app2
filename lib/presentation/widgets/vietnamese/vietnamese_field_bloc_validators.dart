import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class VietnameseFieldBlocValidators {
  static String? required(dynamic value) {
    if (value == null) return 'Ô này cần điền';
    if (value == '') {
      return 'Ô này cần điền';
    }
    return null;
  }

  static String? lightRequired(dynamic value) {
    if (value == null) return 'Bạn chưa điền';
    if (value == '') {
      return 'Bạn chưa điền';
    }
    return null;
  }

  static String? email(String value) {
    if (FieldBlocValidators.email(value) != null) {
      return 'Email này định dạng chưa chuẩn';
    }
    return null;
  }

  static Future<String?> isRegisteredEmail(String email) async {
    try {
      // Fetch sign-in methods for the email address
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      // In case list is not empty
      if (list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        return 'Email này đã được đăng ký';
      } else {
        // Return false because email adress is not in use
      }
    } catch (error) {
      // Handle error
      // ...
      return 'Lỗi';
    }
    return null;
  }

  //6 chữ
  static String? checkLength6(String value) {
    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 kí tự';
    }
    return null;
  }
}

class Hospital {
  static String? checkLength10(String value) {
    if (value.length != 10) {
      return 'Mã bệnh nhân phải có 10 kí tự';
    }
    return null;
  }
}
