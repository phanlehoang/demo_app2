import 'package:demo_app2/authentication/sign_up_screen/sign_up_form_bloc.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/0.1_nice_internet_screen.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/nice_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../presentation/widgets/nice_widgets/2_nice_button.dart';
import '../../presentation/widgets/status/loading_dialog.dart';
import '../../presentation/widgets/status/show_toast.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final signUpFormBloc = SignUpFormBloc();
    return NiceInternetScreen(
      child: FormBlocListener(
        formBloc: signUpFormBloc,
        onSubmitting: (context, state) {
          LoadingDialog.show(context);
        },
        onSuccess: (context, state) {
          LoadingDialog.hide(context);
          showToast('Đăng kí thành công');
        },
        onFailure: (context, state) {
          //show toast
          LoadingDialog.hide(context);
          showToast('Đăng kí thất bại');
        },
        //phải hợp lệ thì mới bấm nút được

        child: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              //full name
              TextFieldBlocBuilder(
                textFieldBloc: signUpFormBloc.fullName,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Họ và tên',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: signUpFormBloc.email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              TextFieldBlocBuilder(
                textFieldBloc: signUpFormBloc.password,
                suffixButton: SuffixButton.obscureText,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              //confirm password
              TextFieldBlocBuilder(
                textFieldBloc: signUpFormBloc.confirmPassword,
                suffixButton: SuffixButton.obscureText,
                decoration: InputDecoration(
                  labelText: 'Xác nhận mật khẩu',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              //button to submit
              NiceButton(
                text: 'Đăng ký',
                onTap: () async {
                  signUpFormBloc.submit();
                },
              )
            ],
          );
        }),
      ),
    );
  }
}
