//create login form bloc

import 'dart:async';

import 'package:demo_app2/presentation/widgets/vietnamese/vietnamese_field_bloc_validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class LoginFormBloc extends FormBloc<String, String> {
  final email = TextFieldBloc(
    validators: [
      //vietnam
      VietnameseFieldBlocValidators.required,
      VietnameseFieldBlocValidators.email,
    ],
  );
  final password = TextFieldBloc(
    validators: [
      VietnameseFieldBlocValidators.required,
    ],
  );
  //khởi tạo
  LoginFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        email,
        password,
      ],
    );
  }

  @override
  FutureOr<void> onSubmitting() async {
    //đăng nhập firebase
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      emitSuccess();
    } catch (e) {
      emitFailure(failureResponse: 'Đăng nhập thất bại');
    }
  }
}
