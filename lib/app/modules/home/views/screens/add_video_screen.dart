import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tik_tok/app/data/constants/constants.dart';
import 'package:tik_tok/app/modules/home/views/screens/confirm_video_screen.dart';
import 'package:tik_tok/app/modules/home/widgets/buttons/custom_button.dart';

import '../../widgets/imagepicker/video_pick_functionality.dart';

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  File? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text("Upload Video", style: CustomTextStyle.kBold18),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomButton(
                onPressed: () async {
                  VideoPickerDialogBox.pickSingleVideo((file) {
                    setState(() {
                      video = file;
                    });
                    if (video != null) {
                      Get.to(() => ConfirmVideoScreen(
                          video: File(video!.path), videoPath: video!.path));
                    }
                  });
                },
                color: CustomColors.redColor,
                child: Text(
                  "Upload Video",
                  style: CustomTextStyle.kBold18,
                )),
          ),
        ));
  }
}
