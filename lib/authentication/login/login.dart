import 'package:demo_app2/authentication/login/diagonal_streak_decoration_screen.dart';
import 'package:demo_app2/authentication/login/welcome_back_widget.dart';
import 'package:demo_app2/authentication/verify/forget_password.dart';
import 'package:demo_app2/data/models/doctor/current_doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

//import flutter bloc
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:glucose_control/verify/phone_home.dart';
import '../../data/models/doctor/doctor.dart';
import '../manage_patient/manager.dart';
import 'doctor_image_login.dart';
import 'enter_email.dart';
import 'home_screen_main_login.dart';
import 'loading_screen.dart';
import 'signup.dart';

import 'dart:io';


class PasswordState {
  bool passwordVisible = true;
  bool flagLogin = false;
  String userCurrent = '';
  String passwordCurrent = '';
  PasswordState ( 
    {this. passwordVisible = true,
    this. flagLogin = false,
    this. userCurrent = '',
    this. passwordCurrent = ''}
  );
  //clone 
  PasswordState clone(){
    return PasswordState(
      passwordVisible: passwordVisible,
      flagLogin: flagLogin,
      userCurrent: userCurrent,
      passwordCurrent: passwordCurrent,
    );
  }
  //toString
  @override
  String toString() {
    return ''' 
    PasswordState{passwordVisible: $passwordVisible, 
    flagLogin: $flagLogin, userCurrent: $userCurrent, 
     passwordCurrent: $passwordCurrent}
    ''';
  }

}

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit() : super(PasswordState());
}

class Login extends StatelessWidget {
  
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final PasswordCubit passwordCubit = PasswordCubit();

  @override
  Widget build(BuildContext context) {
    if (passwordCubit.state.userCurrent != '') _email.text = passwordCubit.state.userCurrent;
    // _password.text = password_current;
    return 
        BlocBuilder(
          bloc: passwordCubit,
          
          builder: (BuildContext context, state) {  
            final passwordState = state as PasswordState;
          return DiagonalStreakDecorationScreen(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
                  child: Column (
                    children: <Widget>[
                      Text(passwordState.toString()),
                      Text('text: ${_email.text}'),
                      LoadingScreen(flag_login: state.flagLogin),
                      LoginContent(email: _email, password: _password, passwordState: passwordState, passwordCubit: passwordCubit),

                    BlocBuilder<CurrentDoctor, Doctor>( 
                    
                      builder: (BuildContext context, state) {
                       return Text(state.email.toString());
                      }
                    )
                    ],
                ),
              ),
            );
              
        
    
  
}
);
  }
}

class LoginContent extends StatelessWidget {
  const LoginContent({
    Key? key,
    required TextEditingController email,
    required TextEditingController password,
    required this.passwordState,
    required this.passwordCubit,
  }) : _email = email, _password = password, super(key: key);

  final TextEditingController _email;
  final TextEditingController _password;
  final PasswordState passwordState;
  final PasswordCubit passwordCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DoctorImageLogin(),
          WelcomeBackWidget(),
        
          // enter email
          EnterEmail(email: _email),
          // enter password
          EnterPassword(password: _password, passwordState: passwordState, passwordCubit: passwordCubit),
          // button login
          LoginButton(passwordCubit: passwordCubit, email: _email, password: _password),
          SignUpButton(),
        ]);
  }
} 

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
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
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          SignUp()),
                  ModalRoute.withName('/login'));
            },
          ),
          InkWell(
            child: Row(
              children: const <Widget>[
                Icon(Icons.lock),
                Text(
                  "Quên mật khẩu",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 3, 42, 75),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const ForgetPassScreen()),
              );
              // );
            },
          ),
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.passwordCubit,
    required TextEditingController email,
    required TextEditingController password,
  }) : _email = email, _password = password, super(key: key);

  final PasswordCubit passwordCubit;
  final TextEditingController _email;
  final TextEditingController _password;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              const Color.fromARGB(255, 1, 112, 203),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          _checkLoginFirebase(
            passwordCubit: passwordCubit,
             email: _email,
              password: _password,
               context: context);
        },
        child: const Text(
          "Đăng nhập",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class EnterPassword extends StatelessWidget {
  const EnterPassword({
    Key? key,
    required TextEditingController password,
    required this.passwordState,
    required this.passwordCubit,
  }) : _password = password, super(key: key);

  final TextEditingController _password;
  final PasswordState passwordState;
  final PasswordCubit passwordCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: _password,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        obscureText: passwordState.passwordVisible,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_outline),
          hintText: 'Nhập mật khẩu',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22.0)),
          labelText: "Mật Khẩu",
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 30, 30, 30),
            fontSize: 15,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
             passwordState. passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
             
              final newPasswordState = PasswordState(
                passwordVisible : !passwordState.passwordVisible,
                flagLogin:passwordState. flagLogin,
                userCurrent : passwordState.userCurrent,
                passwordCurrent : _password.text,
              );
              passwordCubit. emit(newPasswordState);
            },
          ),
        ),
      ),
    );
  }
}

// Thông báo sai khi nhập dữ liệu
  

// Kiểm tra login firebase
  

void showToast(String content, int time) {
    Fluttertoast.showToast(
        msg: content,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: time,
        backgroundColor: const Color.fromARGB(255, 82, 146, 242),
        textColor: Colors.white,
        fontSize: 16.0);
}

void _checkLoginFirebase(
  {required PasswordCubit passwordCubit,
  required TextEditingController email,
  required TextEditingController password,
  required BuildContext context,

  }
) async {
   final state = passwordCubit.state;
   final newState = state.clone();
    newState.passwordCurrent = password.text;
    newState.userCurrent = email.text;
    newState.flagLogin = !state.flagLogin;
    sleep(const Duration(seconds: 1));
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: email.text, password: password.text)
        .then(
      (user) async {
        // print("uid = ${user.user!.uid.toString()}");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('keyLocalLogin', user.user!.uid.toString());
        await Manager(key: user.user!.uid.toString()).readNameUser();
        Manager(key: user.user!.uid.toString()).nameEmailUser =
            user.user!.email! ?? "none@gmail.com";
            passwordCubit.emit(newState);
        context.read<CurrentDoctor>().updateEmail(newState.userCurrent);
      },
    ).catchError((e) {
      password.text = '';
      newState. passwordCurrent = '';
      print("ERRORS: $e");
      // if (flagLogin)flagLogin = !flagLogin;
      // setState(() {
      //   _showToast('Email or password is invalidated', 1);
      // });
      passwordCubit.emit(newState);
      showToast('Email or password is invalidated', 1);
    });
  }

