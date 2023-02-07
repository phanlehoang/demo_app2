import 'package:demo_app2/data/models/doctor/current_doctor.dart';
import 'package:demo_app2/logic/status_cubit/navigator_bar_cubit.dart';
import 'package:demo_app2/presentation/screens/0_home_screens/0_home_screen.dart';
import 'package:demo_app2/presentation/screens/3_setting_screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../presentation/widgets/status/loading_dialog.dart';
import '../../presentation/widgets/status/show_toast.dart';
import '4_button_to_sign_up.dart';
import '3.nice_login_button.dart';
import '5_button_to_forget_password.dart';
import '2.1.login_form_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final loginFormBloc = LoginFormBloc();
    return FormBlocListener(
      formBloc: loginFormBloc,
      onSubmitting: (context, state) {
        LoadingDialog.show(context);
      },
      onSuccess: (context, state) async {
        LoadingDialog.hide(context);
        showToast('Đăng nhập thành công');
        //navigate to home screen
        await context.read<BottomNavigatorBarCubit>().update(0);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
      onFailure: (context, state) {
        //show toast
        LoadingDialog.hide(context);
        showToast('Đăng nhập thất bại');
      },
      child: Builder(builder: (context) {
        return Column(
          children: <Widget>[
            TextFieldBlocBuilder(
              textFieldBloc: loginFormBloc.email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            TextFieldBlocBuilder(
              textFieldBloc: loginFormBloc.password,
              suffixButton: SuffixButton.obscureText,
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            NiceLoginButton(
              onPressed: loginFormBloc.submit,
            ),
            SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                //muốn đặt các button cách xa nhau thì dùng Row
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonToSignUp(),
                  //cách
                  SizedBox(width: 10),
                  ButtonToForgetPassword(),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
