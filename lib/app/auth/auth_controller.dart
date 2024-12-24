import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/remote/api_service.dart';

class AuthController extends GetxController {
  TextEditingController loginPassword = TextEditingController();
  TextEditingController loginNameOrEmail = TextEditingController();
  RxBool isPassObscure = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> doLogin() async {
    var data = await ApiService.postLogin(
        emailOrPhone: loginNameOrEmail.text, password: loginPassword.text);
  }
}
