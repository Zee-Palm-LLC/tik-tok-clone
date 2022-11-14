import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tik_tok/app/data/constants/colors.dart';

ThemeData mainTheme = ThemeData.dark()
    .copyWith(scaffoldBackgroundColor: CustomColors.mobileBackgroundColor);

SystemUiOverlayStyle defaultOverlay = const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarColor: Colors.black);
