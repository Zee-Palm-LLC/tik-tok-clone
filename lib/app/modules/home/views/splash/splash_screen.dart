import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
// ignore: depend_on_referenced_packages
import "package:page_transition/page_transition.dart";
import 'package:tik_tok/app/modules/home/views/auth/auth_wrapper.dart';
import 'package:tik_tok/app/modules/home/views/starter/starter.dart';

import '../../../../data/constants/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: CustomColors.mobileBackgroundColor,
      splash:
          Lottie.asset(CustomAssets.splashIcon, height: 200.h, width: 200.w),
      splashIconSize: double.infinity,
      duration: 3000,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      nextScreen: const AuthWrapper(),
      animationDuration: const Duration(seconds: 1),
    );
  }
}
