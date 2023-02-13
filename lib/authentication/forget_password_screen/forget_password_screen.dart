import 'dart:async';

import 'package:demo_app2/presentation/widgets/nice_widgets/nice_export.dart';
import 'package:demo_app2/presentation/widgets/status/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../presentation/widgets/vietnamese/vietnamese_field_bloc_validators.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NiceInternetScreen(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Nhập email của bạn để đặt lại mật khẩu',
          ),
          const SizedBox(height: 20),
          BlocProvider<ResetPasswordFormBloc>(
            create: (context) => ResetPasswordFormBloc(),
            child: Builder(builder: (ct) {
              final formBloc = BlocProvider.of<ResetPasswordFormBloc>(ct);
              return FormBlocListener(
                formBloc: formBloc,
                onSuccess: (context, state) {
                  showToast('Đã gửi email');
                },
                onFailure: (context, state) {
                  showToast('Có lỗi xảy ra');
                },
                child: Column(
                  //cho vào giữa
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: TextFieldBlocBuilder(
                        textFieldBloc: formBloc.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    NiceButton(
                        text: 'Gửi',
                        onTap: () {
                          formBloc.submit();
                        }),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    ));
  }
}

//làm sao thay đổi nội dung bức thư viết cho email này
//https://firebase.google.com/docs/auth/web/manage-users?authuser=0#send_a_user_a_verification_email
class ResetPasswordFormBloc extends FormBloc<String, String> {
  final email = TextFieldBloc(
    validators: [
      VietnameseFieldBlocValidators.required,
      VietnameseFieldBlocValidators.email
    ],
  );
  //add field blocs to the form bloc
  ResetPasswordFormBloc() {
    addFieldBlocs(fieldBlocs: [email]);
  }
  @override
  FutureOr<void> onSubmitting() {
    resetPassword(email: email.value).then((status) {
      if (status == null) {
        emitSuccess(canSubmitAgain: true);
      } else {
        emitFailure(failureResponse: status.toString());
      }
    });
  }
}

Future<String?> resetPassword({required String email}) async {
  dynamic _status;
  await FirebaseAuth.instance
      .sendPasswordResetEmail(email: email)
      .then((value) => _status = null)
      .catchError((e) => _status = e);
  return _status;
}
