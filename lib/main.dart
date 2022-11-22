import 'package:ecom/controllers/admin_controller/admin_cubit.dart';
import 'package:ecom/controllers/controllers.dart';
import 'package:ecom/data/hive_config.dart';
import 'package:ecom/data/local/auth_local.dart';
import 'package:ecom/theme/app_theme.dart';
import 'package:ecom/utils/restart_util.dart';
import 'package:ecom/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  //Ensure that the application Initialized successfully
  WidgetsFlutterBinding.ensureInitialized();

  // Connect to Firebase project
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //Connect Hive local storage
  await HiveConfig().init();
  bool isLoggedIn = await SharedPrefWrapper.instance.getBool('isLoggedIn');
  bool isAdmin = await SharedPrefWrapper.instance.getBool('isAdmin');
  // Run application
  AuthLocalImpl().saveCurrentUser();
  final appState = AppState();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => appState),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => CheckoutProvider()),
        Provider(create: (context) => MyRouter(appState, isLoggedIn, isAdmin)),
      ],
      child: const ECom(),
    ),
  );
}

class ECom extends StatefulWidget {
  const ECom({super.key});

  @override
  State<ECom> createState() => _EComState();
}

class _EComState extends State<ECom> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = Provider.of<MyRouter>(context, listen: false).myRouter;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AdminCubit(),
        )
      ],
      child: RestartWidget(
        child: ScreenUtilInit(
          designSize: const Size(360, 640),
          builder: (context, child) {
            return MaterialApp.router(
              title: 'Ecom',
              theme: AppTheme.lightTheme,
              debugShowCheckedModeBanner: false,
              routerDelegate: router.routerDelegate,
              routeInformationParser: router.routeInformationParser,
              routeInformationProvider: router.routeInformationProvider,
            );
          },
        ),
      ),
    );
  }
}
