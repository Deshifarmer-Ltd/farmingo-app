import 'package:get/get.dart';
import 'common_controller.dart';
class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CommonController(),permanent: true);

  }
}