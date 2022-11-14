import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tok/app/modules/home/views/landingPage/bottom_bar.dart';
import 'package:tik_tok/app/modules/home/views/starter/starter.dart';

import '../../controllers/auth_controller.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
        init: AuthController(),
        builder: (ac) {
          if (ac.user == null) {
            return const StarterScreen();
          } else {
            return const LandingPage();
          }
        });
  }
}
