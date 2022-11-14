import 'dart:io';

import 'package:get/get.dart';

import '../../../../services/video_picker_services.dart';
import '../dialogs/image_pick_dialog.dart';

class VideoPickerDialogBox {
  static Future<File?> pickSingleVideo(Function(File) callBack) async {
    File? pickedFile;
    Get.dialog(ImagePickDialog(
      heading: 'Select Image',
      cameraCallback: () async {
        Get.back();
        0.5.seconds.delay().then((value) async {
          pickedFile = await VideoPickerServices().getVideoFromCamera();
          if (pickedFile != null) {
            callBack(pickedFile!);
            return pickedFile;
          }
        });
      },
      galleryCallback: () async {
        Get.back();
        0.5.seconds.delay().then((value) async {
          pickedFile = await VideoPickerServices().getVideoFromGallery();
          if (pickedFile != null) {
            callBack(pickedFile!);

            return pickedFile;
          }
        });
      },
    ));
    return pickedFile;
  }
}
