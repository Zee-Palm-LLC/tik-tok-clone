import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class VideoPickerServices {
  File? video;
  final _picker = ImagePicker();

  Future<File?> getVideoFromGallery() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      video = File(pickedFile.path);
      return video;
    } else {
      Get.snackbar("No Video", "Video not Selected");
      return null;
    }
  }

  Future<File?> getVideoFromCamera() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      video = File(pickedFile.path);
      return video;
    } else {
      Get.snackbar("No Video", "Video not Selected");
      return null;
    }
  }
}
