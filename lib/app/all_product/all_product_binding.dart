import 'package:get/get.dart';

import '../home/common_controller.dart';

class AllProductBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => CommonController());
  }




}