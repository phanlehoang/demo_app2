//create a simple app
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo_app2/authentication/login_screen/1_login_screen.dart';
import 'package:demo_app2/logic/global/current_export.dart';
import 'package:demo_app2/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:demo_app2/presentation/router/app_router.dart';
import 'package:demo_app2/presentation/screens/0_home_screens/0_home_screen.dart';
import 'package:demo_app2/presentation/screens/3_setting_screens/remember_login_cubit.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/nice_export.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'data/models/2.3_current_profile_cubit.dart';
import 'data/models/doctor/current_doctor.dart';
import 'logic/status_cubit/internet/internet_cubit.dart';
import 'logic/status_cubit/navigator_bar_cubit.dart';
import 'logic/status_cubit/reference_warning_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  await Firebase.initializeApp();
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //internet cubit
        BlocProvider<InternetCubit>(
          create: (internetCubitContext) => InternetCubit(
            connectivity: Connectivity(),
          ),
        ),
        BlocProvider<BottomNavigatorBarCubit>(
          create: (navigatorBarCubitContext) => BottomNavigatorBarCubit(),
        ),
        //navigator patient cubit
        BlocProvider<PatientNavigatorBarCubit>(
          create: (navigatorBarCubitContext) => PatientNavigatorBarCubit(),
        ),
        //doctor navigator cubit
        BlocProvider<DoctorNavigatorBarCubit>(
          create: (navigatorBarCubitContext) => DoctorNavigatorBarCubit(),
        ),
        //current group id cubit
        BlocProvider<CurrentGroupIdCubit>(
          create: (currentGroupIdCubitContext) => CurrentGroupIdCubit(),
        ),
        //current profile cubit
        BlocProvider<CurrentProfileCubit>(
          create: (currentProfileCubitContext) => CurrentProfileCubit(),
        ),
        //current method cubit

        //time check cubit
        BlocProvider<TimeCheckCubit>(
          create: (timeCheckCubitContext) => TimeCheckCubit(
            ticker: secondStream(),
          ),
        ),
        //remember login cubit
        BlocProvider<RememberLoginCubit>(
          create: (rememberLoginCubitContext) => RememberLoginCubit(),
        ),
        //reference warning cubit
        BlocProvider<ReferenceWarningCubit>(
          create: (referenceWarningCubitContext) => ReferenceWarningCubit(),
        ),
      ],
      child: DemoApp2(appRouter: appRouter),
    );
  }
}

class DemoApp2 extends StatelessWidget {
  const DemoApp2({
    super.key,
    required this.appRouter,
  });

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    final RememberLoginCubit rememberLoginCubit =
        BlocProvider.of<RememberLoginCubit>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: winterTheme(Brightness.light),
      onGenerateRoute: appRouter.onGeneratedRoute,
      home: BlocBuilder<RememberLoginCubit, String>(
        builder: (context, state) {
          if (state == 'Unknown') {
            return LoginScreen();
          } else {
            return HomeScreen();
          }
        },
      ),
    );
  }
}
