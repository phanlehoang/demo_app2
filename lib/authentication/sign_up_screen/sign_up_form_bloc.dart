//create login form bloc

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/presentation/widgets/vietnamese/vietnamese_field_bloc_validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SignUpFormBloc extends FormBloc<String, String> {
  final fullName = TextFieldBloc(
    validators: [
      //vietnam
      VietnameseFieldBlocValidators.required,
    ],
  );
  final email = TextFieldBloc(
      validators: [
        //vietnamc
        VietnameseFieldBlocValidators.required,
        VietnameseFieldBlocValidators.email,
      ],
      //kiểm tra email đã đăng ký chưa
      asyncValidatorDebounceTime: Duration(milliseconds: 300),
      asyncValidators: [
        VietnameseFieldBlocValidators.isRegisteredEmail,
      ]);
  final password = TextFieldBloc(
    validators: [
      VietnameseFieldBlocValidators.required,
      VietnameseFieldBlocValidators.checkLength6,
    ],
  );
  final confirmPassword = TextFieldBloc(
    validators: [
      VietnameseFieldBlocValidators.required,
    ],
  );

  Validator<String> _confirmPassword(
    TextFieldBloc passwordTextFieldBloc,
  ) {
    return (String? confirmPassword) {
      if (confirmPassword == passwordTextFieldBloc.value) {
        return null;
      }
      return 'Mật khẩu cần khớp';
    };
  }

  SignUpFormBloc() {
    addFieldBlocs(
      fieldBlocs: [fullName, email, password, confirmPassword],
    );

    confirmPassword
      ..addValidators([_confirmPassword(password)])
      ..subscribeToFieldBlocs([password]);

    // Or you can use built-in confirm password validator
    // confirmPassword
    //   ..addValidators([FieldBlocValidators.confirmPassword(password)])
    //   ..subscribeToFieldBlocs([password]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    //đăng nhập firebase
    try {
      //sign up
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(email.value)
          .set({
        'fullName': fullName.value,
        'email': email.value,
        'password': password.value,
      });
      emitSuccess();
    } catch (e) {
      emitFailure(failureResponse: 'Đăng kí thất bại');
    }
  }
}
