import 'package:get/get.dart';
import 'package:tik_tok/app/modules/home/controllers/auth_controller.dart';
import 'package:tik_tok/app/modules/home/controllers/search_controller.dart';
import 'package:tik_tok/app/modules/home/controllers/user_controller.dart';

import '../controllers/video_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => UploadVideoController(), fenix: true);
    Get.lazyPut(() => SearchController(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
  }
}
