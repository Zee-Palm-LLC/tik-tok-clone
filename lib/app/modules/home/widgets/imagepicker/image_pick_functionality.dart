import 'dart:io';

import 'package:get/get.dart';

import '../../../../services/image_picker_services.dart';
import '../dialogs/image_pick_dialog.dart';

class ImagePickerDialogBox {
  static Future<File?> pickSingleImage(Function(File) callBack) async {
    File? pickedFile;
    Get.dialog(ImagePickDialog(
      heading: 'Select Image',
      cameraCallback: () async {
        Get.back();
        0.5.seconds.delay().then((value) async {
          pickedFile = await ImagePickerServices().getImageFromCamera();
          if (pickedFile != null) {
            callBack(pickedFile!);
            return pickedFile;
          }
        });
      },
      galleryCallback: () async {
        Get.back();
        0.5.seconds.delay().then((value) async {
          pickedFile = await ImagePickerServices().getImageFromGallery();
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
