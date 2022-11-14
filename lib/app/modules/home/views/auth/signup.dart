import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tik_tok/app/modules/home/controllers/auth_controller.dart';
import 'package:tik_tok/app/modules/home/widgets/imagepicker/image_pick_functionality.dart';
import 'package:tik_tok/app/services/firebase_storage.dart';
import '../../../../data/constants/constants.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/buttons/custom_text_button.dart';
import '../../widgets/imagepicker/image_picker_card.dart';
import '../../widgets/textfields/custom_textformfield.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SignUpScreen> {
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  AuthController ac = Get.find<AuthController>();
  File? image;
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Form(
          key: _formKey,
          child: ListView(physics: const BouncingScrollPhysics(), children: [
            SizedBox(height: 64.h),
            SvgPicture.asset(CustomAssets.logo,
                color: CustomColors.primaryColor, height: 64.h),
            SizedBox(height: 34.h),
            Center(
                child: SelectImageWidget(
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: CustomColors.primaryColor)),
                      child: CircleAvatar(
                        radius: 74.r,
                        backgroundImage: image != null
                            ? FileImage(image!)
                            : const AssetImage(CustomAssets.kPersonIcon)
                                as ImageProvider,
                      ),
                    ),
                    selectImageCallback: () async {
                      ImagePickerDialogBox.pickSingleImage((file) => {
                            setState(() {
                              image = file;
                            })
                          });
                    })),
            SizedBox(height: 24.h),
            TextFieldInput(
              textEditingController: _username,
              hintText: 'Username',
              textInputType: TextInputType.name,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please Enter Your username';
                }
                return null;
              },
            ),
            SizedBox(height: 24.h),
            TextFieldInput(
              textEditingController: _email,
              hintText: 'Email',
              textInputType: TextInputType.emailAddress,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please Enter Your Email';
                } else if (!val.isEmail) {
                  return 'Enter a Valid Email Address';
                }
                return null;
              },
            ),
            SizedBox(height: 24.h),
            TextFieldInput(
              textEditingController: _password,
              hintText: 'Password',
              isPass: true,
              textInputType: TextInputType.visiblePassword,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please enter your password';
                } else if (val.length < 6) {
                  return 'Your password length must be greater than 6 characters';
                }
                return null;
              },
            ),
            SizedBox(height: 34.h),
            CustomButton(
                color: CustomColors.primaryColor,
                onPressed: () async {
                  imageUrl = await FirebaseStorageServices.uploadToStorage(
                      file: image!, folderName: 'profileImages');
                  await ac.registerUser(
                    profilePic: imageUrl ?? '',
                    email: _email.text.trim(),
                    password: _password.text.trim(),
                    name: _username.text,
                  );
                },
                child: Text(
                  "Sign Up",
                  style: CustomTextStyle.kMedium16
                      .copyWith(color: CustomColors.mobileBackgroundColor),
                )),
            SizedBox(height: 110.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                    style: CustomTextStyle.kMedium16),
                CustomTextButton(
                  onPressed: () {
                    Get.to(() => LoginScreen(),
                        duration: const Duration(milliseconds: 200));
                  },
                  text: "Login",
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
