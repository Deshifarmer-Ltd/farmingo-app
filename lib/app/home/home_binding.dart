import 'package:get/get.dart';
import '../auth/auth_controller.dart';
import 'common_controller.dart';
class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CommonController(),permanent: true);
    Get.put(AuthController(),permanent: true);

  }
}