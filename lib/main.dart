import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:tik_tok/app/data/constants/constants.dart';
import 'package:tik_tok/app/modules/home/bindings/home_binding.dart';
import 'package:tik_tok/app/modules/home/views/splash/splash_screen.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      builder: (context, child) => GetMaterialApp(
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        title: 'TikTok',
        theme: mainTheme,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.downToUp,
        initialBinding: HomeBinding(),
        home: const SplashScreen(),
      ),
    );
  }
}
